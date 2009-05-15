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

      context.root(:ruby => true) do |r|

        r.check { SpiderMonkey.JS_GetProperty(context, global, "Johnson", johnson_value) }

        r.add(johnson_value)

        if SpiderMonkey.JSVAL_IS_OBJECT(johnson_value.read_long) == SpiderMonkey::JS_FALSE
          raise "Unable to retrieve Johnson from JSLand"
        end

        js_object = FFI::MemoryPointer.new(:pointer)
        SpiderMonkey.JS_ValueToObject(context, johnson_value.read_long, js_object)

        symbol_value = FFI::MemoryPointer.new(:long)

        r.check { SpiderMonkey.JS_GetProperty(context, js_object.read_pointer, "Symbol", symbol_value) }

        r.add(symbol_value)

        if SpiderMonkey.JSVAL_IS_OBJECT(symbol_value.read_long) == SpiderMonkey::JS_FALSE
          raise "Unable to retrieve Johnson.Symbol from JSLand"
        end

        symbol_object = FFI::MemoryPointer.new(:pointer)
        SpiderMonkey.JS_ValueToObject(context, symbol_value.read_long, symbol_object)

        r.add(symbol_object)

        is_a_symbol = FFI::MemoryPointer.new(:int)

        r.check { SpiderMonkey.JS_HasInstance(context, symbol_object.read_pointer, js_value, is_a_symbol) }

        is_a_symbol.read_int != SpiderMonkey::JS_FALSE

      end      
    end

    def convert_symbol_to_js(symbol)
      to_s = symbol.to_s
      name = SpiderMonkey.JS_StringToValue(context, SpiderMonkey.JS_NewStringCopyN(context, to_s, to_s.size))

      property_value = FFI::MemoryPointer.new(:long)
      rvalue = FFI::MemoryPointer.new(:long)
      js_object = FFI::MemoryPointer.new(:pointer)
      
      context.root do |r|

        r.check { SpiderMonkey.JS_GetProperty(context, global, "Johnson", property_value) }

        r.add(property_value)

        r.check { SpiderMonkey.JS_ValueToObject(context, property_value.read_long, js_object) }
        
        r.check { SpiderMonkey.JS_CallFunctionName(context, 
                                                   js_object.read_pointer,
                                                   "symbolize", 
                                                   1, 
                                                   FFI::MemoryPointer.new(:long).write_long(name), 
                                                   rvalue) }
        rvalue

      end
    end

    def raise_js_error_in_ruby(runtime)
      # ex = FFI::MemoryPointer.new(:long)
      # if SpiderMonkey.JS_IsExceptionPending(context) == JS_TRUE
      #   SpiderMonkey.JS_GetPendingException(context, ex)
      #   # JS_AddNamedRoot(context, &(johnson_context->ex), "raise_js_error_in_ruby");
      #   SpiderMonkey.JS_ClearPendingException(context);
      #   # JS_RemoveRoot(context, &(johnson_context->ex));
      # end
      # unless ex.null?
      #   Runtime.raise_js_exception(convert_to_ruby(ex.read_long))
      # end
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
