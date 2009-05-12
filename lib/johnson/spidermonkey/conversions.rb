module Johnson
  module Conversions

    def convert_ruby_string_to_js(ruby)
      js_string = SpiderMonkey.JS_NewStringCopyN(context, ruby, ruby.size)
      js_value = SpiderMonkey.JS_StringToValue(context, js_string)
      FFI::MemoryPointer.new(:long).write_long(js_value)      
    end

    def convert_js_string_to_ruby(str)
      str_ptr = SpiderMonkey.JS_GetStringBytes(str);
    end

    def js_value_is_symbol?(js_value)
      johnson_value = FFI::MemoryPointer.new(:long)
      SpiderMonkey.JS_GetProperty(context, global, "Johnson", johnson_value)

      if SpiderMonkey.JSVAL_IS_OBJECT(johnson_value.read_long) == SpiderMonkey::JS_FALSE
        raise "Unable to retrieve Johnson from JSLand"
      end

      js_object = FFI::MemoryPointer.new(:pointer)
      SpiderMonkey.JS_ValueToObject(context, johnson_value.read_long, js_object)

      symbol_value = FFI::MemoryPointer.new(:long)
      
      SpiderMonkey.JS_GetProperty(context, js_object.read_pointer, "Symbol", symbol_value)

      if SpiderMonkey.JSVAL_IS_OBJECT(symbol_value.read_long) == SpiderMonkey::JS_FALSE
        raise "Unable to retrieve Johnson.Symbol from JSLand"
      end

      symbol_object = FFI::MemoryPointer.new(:pointer)
      SpiderMonkey.JS_ValueToObject(context, symbol_value.read_long, symbol_object)

      is_a_symbol = FFI::MemoryPointer.new(:int)
      SpiderMonkey.JS_HasInstance(context, symbol_object.read_pointer, js_value, is_a_symbol)

      is_a_symbol.read_int != SpiderMonkey::JS_FALSE
      
    end

    def convert_symbol_to_js(symbol)
      to_s = symbol.to_s
      name = SpiderMonkey.JS_StringToValue(context, SpiderMonkey.JS_NewStringCopyN(context, to_s, to_s.size))

      property_value = FFI::MemoryPointer.new(:long)
      rvalue = FFI::MemoryPointer.new(:long)
      js_object = FFI::MemoryPointer.new(:pointer)

      SpiderMonkey.JS_GetProperty(context, global, "Johnson", property_value)
      SpiderMonkey.JS_ValueToObject(context, property_value.read_long, js_object)

      SpiderMonkey.JS_CallFunctionName(context, 
                                       js_object.read_pointer,
                                       "symbolize", 
                                       1, 
                                       FFI::MemoryPointer.new(:long).write_long(name), 
                                       rvalue)
      rvalue
    end

    def raise_js_error_in_ruby(runtime)
    end

    def report_ruby_error_in_js(runtime, state, old_errinfo)
    end

    def convert_float_or_bignum_to_js(float_or_bignum)
      js = FFI::MemoryPointer.new(:long)
      SpiderMonkey.JS_NewNumberValue(context, float_or_bignum.to_f, js)
      js
    end

    def convert_to_js(ruby)

      result = case ruby

               when Fixnum
                 FFI::MemoryPointer.new(:long).write_long(SpiderMonkey.INT_TO_JSVAL(ruby))
                 
               when TrueClass
                 FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_TRUE)

               when FalseClass
                 FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_FALSE)

               when Float, Bignum
                 convert_float_or_bignum_to_js(ruby)

               when Symbol
                 convert_symbol_to_js(ruby)
                 
               when String
                 convert_ruby_string_to_js(ruby)

               when NilClass
                 FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_NULL)

               when Class, Hash, Module, File, Struct, Object, Array
                 if ruby.kind_of?(SpiderMonkey::RubyLandProxy)
                   jsvalue = ruby.js_value
                   FFI::MemoryPointer.new(:long).write_long(jsvalue)
                 else
                   jsvalue = make_js_land_proxy(ruby)
                   FFI::MemoryPointer.new(:long).write_long(jsvalue)
                 end

               end
    end

    def convert_to_ruby(js)

      return nil if js == SpiderMonkey::JSVAL_NULL

      result = case SpiderMonkey.JS_TypeOfValue(context, js)
                 
               when SpiderMonkey::JSTYPE_VOID
                 nil

               when SpiderMonkey::JSTYPE_NUMBER
                 if SpiderMonkey.JSVAL_IS_INT(js)
                   SpiderMonkey.JSVAL_TO_INT(js)
                 else
                   rvalue = FFI::MemoryPointer.new(:double)
                   SpiderMonkey.JS_ValueToNumber(context, js, rvalue)
                   rvalue.get_double(0)
                 end

               when SpiderMonkey::JSTYPE_OBJECT, SpiderMonkey::JSTYPE_FUNCTION
                 
                 if SpiderMonkey.JS_ObjectToValue(context, global) == js
                   return SpiderMonkey::RubyLandProxy.make_ruby_land_proxy(self, js)
                 end  

                 if js_value_is_symbol?(js)
                   return SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(context, js)).to_sym
                 end

                 if js_value_is_proxy?(js)
                   return unwrap_js_land_proxy(js)
                 end
                 
                 return SpiderMonkey::RubyLandProxy.make_ruby_land_proxy(self, js)


               when SpiderMonkey::JSTYPE_STRING
                 convert_js_string_to_ruby(SpiderMonkey.JS_ValueToString(context, js))

               when SpiderMonkey::JSTYPE_BOOLEAN
                 js == SpiderMonkey::JSVAL_TRUE ? true : false

               end
    end

    
  end
end
