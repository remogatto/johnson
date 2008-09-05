
#include "ruby.h"
#include <v8.h>

#ifndef StringValueLen
#define StringValueLen(v) (RSTRING(v)->len)
#endif

#ifndef UNUSED
# if defined(__GNUC__)
#  define MAYBE_UNUSED(name) name __attribute__((unused))
#  define UNUSED(name) MAYBE_UNUSED(UNUSED_ ## name)
# else
#  define MAYBE_UNUSED(name) name
#  define UNUSED(name) name
# endif
#endif

using namespace v8;

Persistent<Context> _context;
Persistent<FunctionTemplate> tJSLandProxy;

typedef struct {
   Persistent<Object> handle;
} RubyLandProxy;

VALUE cContext;
VALUE cRubyLandProxy;

static bool ruby_value_is_proxy(VALUE maybe_proxy) {
   return cRubyLandProxy == CLASS_OF(maybe_proxy);
}
static bool js_value_is_proxy(Handle<Value> maybe_proxy) {
   return tJSLandProxy->HasInstance(maybe_proxy);
}

static Persistent<Object> extract_from_ruby_land_proxy(VALUE proxy) {
   RubyLandProxy *our_proxy;
   Data_Get_Struct(proxy, RubyLandProxy, our_proxy);
   return our_proxy->handle;
}
static VALUE extract_from_js_land_proxy(Handle<Value> proxy) {
   return (VALUE)External::Cast(*(proxy->ToObject()->GetInternalField(0)))->Value();
}

static void rubyland_finalize(RubyLandProxy* our_proxy) {
   our_proxy->handle.Dispose();
}

static Handle<Value> check_js(Handle<Value> result) {
   if (result.IsEmpty()) {
      rb_raise(rb_eRuntimeError, "Invalid result");
   } else {
      return result;
   }
}

static VALUE make_ruby_land_proxy(Handle<Object> value) {
   check_js(value);
   RubyLandProxy* our_proxy;
   VALUE proxy = Data_Make_Struct(cRubyLandProxy, RubyLandProxy, 0, rubyland_finalize, our_proxy);
   our_proxy->handle = Persistent<Object>::New(value);
   return proxy;
}
static Handle<Object> make_js_land_proxy(VALUE value) {
   Handle<Object> proxy = tJSLandProxy->GetFunction()->NewInstance();
   proxy->SetInternalField(0, External::New((void*)value));
   return proxy;
}

#define CB(name) reinterpret_cast<VALUE(*)(...)>(name)

static VALUE convert_js_to_ruby_string(Handle<Value> value) {
   Handle<String> str = value->ToString();
   int len = str->Length();
   char buffer[len];
   str->WriteAscii(buffer);
   return rb_str_new(buffer, len);
}
static Local<String> convert_ruby_to_js_string(VALUE inval) {
   VALUE str = rb_funcall(inval, rb_intern("to_s"), 0);
   return String::New(StringValuePtr(str), StringValueLen(str));
}

static VALUE convert_js_to_ruby(Handle<Value> value) {
   check_js(value);
   if (value->IsUndefined() || value->IsNull()) return Qnil;
   if (value->IsTrue()) return Qtrue;
   if (value->IsFalse()) return Qfalse;
   if (value->IsString()) return convert_js_to_ruby_string(value);
   if (value->IsInt32()) return INT2NUM(value->Int32Value());
   if (value->IsNumber()) return rb_float_new(value->NumberValue());
   if (value->IsObject()) {
      if (js_value_is_proxy(value)) return extract_from_js_land_proxy(value);
      return make_ruby_land_proxy(value->ToObject());
   } else {
      rb_raise(rb_eArgError, "Unknown JS type");
   }
}
static Handle<Value> convert_ruby_to_js(VALUE value) {
   switch(TYPE(value)) {
      case T_NIL: return Null();
      case T_TRUE: return True();
      case T_FALSE: return False();
      case T_STRING: return convert_ruby_to_js_string(value);
      case T_FIXNUM: return Integer::New(FIX2INT(value));
      case T_FLOAT:
      case T_BIGNUM: return Number::New(NUM2DBL(value));
      case T_SYMBOL: return String::NewSymbol(StringValueCStr(value));
      case T_DATA:
         if (ruby_value_is_proxy(value))
            return extract_from_ruby_land_proxy(value);
      default:
         return make_js_land_proxy(value);
   }
}

#define PrepareScope \
   HandleScope handle_scope; \
   Context::Scope context_scope(_context); \
   TryCatch safe;

static VALUE context_evaluate(VALUE self, VALUE source) {
   PrepareScope;
   Handle<String> str = convert_ruby_to_js_string(source);
   Handle<Value> result = Script::Compile(str)->Run();
   return convert_js_to_ruby(result);
}

static VALUE rubyland_to_s(VALUE self) {
   PrepareScope;
   return convert_js_to_ruby_string(extract_from_ruby_land_proxy(self));
}
static VALUE rubyland_key_p(VALUE self, VALUE name) {
   PrepareScope;
   return extract_from_ruby_land_proxy(self)->Has(convert_ruby_to_js_string(name)) ? Qtrue : Qfalse;
}
static VALUE rubyland_delete(VALUE self, VALUE name) {
   PrepareScope;
   return extract_from_ruby_land_proxy(self)->Delete(convert_ruby_to_js_string(name)) ? Qtrue : Qfalse;
}
static VALUE rubyland_get(VALUE self, VALUE name) {
   PrepareScope;
   return convert_js_to_ruby(extract_from_ruby_land_proxy(self)->Get(convert_ruby_to_js(name)));
}
static VALUE rubyland_set(VALUE self, VALUE name, VALUE value) {
   PrepareScope;
   return extract_from_ruby_land_proxy(self)->Set(convert_ruby_to_js(name), convert_ruby_to_js(value)) ? Qtrue : Qfalse;
}
static VALUE rubyland_function_p(VALUE self) {
   PrepareScope;
   return extract_from_ruby_land_proxy(self)->IsFunction() ? Qtrue : Qfalse;
}
static VALUE rubyland_respond_to_p(VALUE self, VALUE sym) {
   VALUE stringval = rb_funcall(sym, rb_intern("to_s"), 0);
   char* name = StringValuePtr(stringval);

   if (name[StringValueLen(stringval) - 1] == '=')
      return Qtrue;

   if (rubyland_key_p(self, sym))
      return Qtrue;

   return rb_call_super(1, &sym);
}
static VALUE rubyland_each(VALUE self) {
   PrepareScope;
   // TODO
   return Qnil;
}
static VALUE rubyland_length(VALUE self) {
   PrepareScope;
   // TODO
   return Qnil;
}
static VALUE rubyland_native_call(int argc, VALUE* argv, VALUE self) {
   PrepareScope;
   if (argc < 1)
      rb_raise(rb_eArgError, "Target object required");
   Handle<Object> _this = extract_from_ruby_land_proxy(self);
   if (!_this->IsFunction())
      rb_raise(rb_eArgError, "Not a JS function");
   Function* func = Function::Cast(*_this);
   Handle<Value> target = convert_ruby_to_js(argv[0]);
   if (target->IsNull())
      target = _context->Global();
   if (!target->IsObject())
      rb_raise(rb_eArgError, "Target must be an object");
   Handle<Value> result;
   if (argc == 1) {
      result = func->Call(target->ToObject(), 0, NULL);
   } else {
      Handle<Value> args[argc - 1];
      for (int i = 1; i < argc; i++) {
         args[i - 1] = convert_ruby_to_js(argv[i]);
      }
      result = func->Call(target->ToObject(), argc - 1, args);
   }
   return convert_js_to_ruby(result);
}

static Handle<Value> jsland_get(Local<String> name, const AccessorInfo& info) {
   VALUE self = extract_from_js_land_proxy(info.This());
   VALUE rname = convert_js_to_ruby_string(name);
   return convert_ruby_to_js(rb_funcall(self, rb_intern(StringValueCStr(rname)), 0));
}
static Handle<Value> jsland_set(Local<String> name, Local<Value> value, const AccessorInfo& info) {
   VALUE self = extract_from_js_land_proxy(info.This());
   VALUE rname = convert_js_to_ruby_string(name);
   // TODO
   return value;
}
static Handle<Boolean> jsland_has(Local<String> name, const AccessorInfo& info) {
   VALUE self = extract_from_js_land_proxy(info.This());
   VALUE rname = convert_js_to_ruby_string(name);
   // TODO
   return False();
}
static Handle<Boolean> jsland_delete(Local<String> name, const AccessorInfo& info) {
   VALUE self = extract_from_js_land_proxy(info.This());
   VALUE rname = convert_js_to_ruby_string(name);
   // TODO
   return False();
}
static Handle<Array> jsland_enum(const AccessorInfo& info) {
   VALUE self = extract_from_js_land_proxy(info.This());
   // TODO
   return Array::New();
}
static Handle<Value> jsland_call(const Arguments& args) {
   VALUE self = extract_from_js_land_proxy(args.This());
   int len = args.Length();
   VALUE ruby_args = rb_ary_new2(len);
   for (int i = 0; i < len; i++) {
      rb_ary_store(ruby_args, i, convert_js_to_ruby(args[i]));
   }
   return convert_ruby_to_js(rb_apply(self, rb_intern("call"), ruby_args));
}

extern "C" void Init_rubyv8() {
   VALUE johnson = rb_define_module("Johnson");

   VALUE v8 = rb_define_module_under(johnson, "V8");
   cContext = rb_define_class_under(v8, "Context", rb_cObject);
   rb_define_method(cContext, "evaluate", CB(context_evaluate), 1);

   cRubyLandProxy = rb_define_class_under(v8, "RubyLandProxy", rb_cObject);
   rb_define_method(cRubyLandProxy, "delete", CB(rubyland_delete), 1);
   rb_define_method(cRubyLandProxy, "key?", CB(rubyland_key_p), 1);
   rb_define_method(cRubyLandProxy, "[]", CB(rubyland_get), 1);
   rb_define_method(cRubyLandProxy, "[]=", CB(rubyland_set), 2);
   rb_define_method(cRubyLandProxy, "function?", CB(rubyland_function_p), 0);
   rb_define_method(cRubyLandProxy, "respond_to?", CB(rubyland_respond_to_p), 1);
   rb_define_method(cRubyLandProxy, "each", CB(rubyland_each), 0);
   rb_define_method(cRubyLandProxy, "length", CB(rubyland_length), 0);
   rb_define_method(cRubyLandProxy, "to_s", CB(rubyland_to_s), 0);
   rb_define_method(cRubyLandProxy, "native_call", CB(rubyland_native_call), -1);


   HandleScope handle_scope;
   _context = Persistent<Context>::New(Context::New());

   Context::Scope context_scope(_context);

   tJSLandProxy = Persistent<FunctionTemplate>::New(FunctionTemplate::New());
   tJSLandProxy->SetHiddenPrototype(true);
   tJSLandProxy->SetClassName(String::New("RubyObject"));
   tJSLandProxy->InstanceTemplate()->SetInternalFieldCount(1);
   tJSLandProxy->InstanceTemplate()->SetNamedPropertyHandler(jsland_get, jsland_set, jsland_has, jsland_delete, jsland_enum);
   tJSLandProxy->InstanceTemplate()->SetCallAsFunctionHandler(jsland_call);
}

