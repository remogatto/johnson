#include <ruby.h>
#include <JavaScriptCore/JavaScriptCore.h>

extern "C"
void Init_javascriptcore()
{
  VALUE johnson = rb_define_module("Johnson");
  VALUE javascriptcore = rb_define_module_under(johnson, "JavaScriptCore");

  rb_define_const(javascriptcore, "VERSION",
		  rb_obj_freeze(rb_str_new2("UNKNOWN")));

  // FIXME: this is just here to prove that we're loading the
  // JavaScriptCore framework and some reasonable headers. Remove it
  // when we have some actual functionality working.

  JSClassCreate(&kJSClassDefinitionEmpty);
}
