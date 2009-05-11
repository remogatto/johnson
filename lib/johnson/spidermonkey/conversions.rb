module Johnson
  module Conversions

    def convert_to_js(ruby)
      if ruby.kind_of?(Fixnum)
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey.INT_TO_JSVAL(ruby))
        
      elsif ruby == true
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_TRUE)

      elsif ruby == false
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_FALSE)

      elsif ruby.kind_of?(Float) or ruby.kind_of?(Bignum)
        convert_float_or_bignum_to_js(ruby)

      elsif ruby.kind_of?(String)
        js_str_ptr = SpiderMonkey.JS_NewStringCopyN(context, ruby, ruby.size)
        jsvalue = SpiderMonkey.JS_StringToValue(context, js_str_ptr)
        FFI::MemoryPointer.new(:long).write_long(jsvalue)

      elsif ruby.nil?
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_NULL)

      elsif ruby.kind_of?(Object) || ruby.kind_of?(Array)
        # FIXME: JSLandProxy should be a module
        if ruby.kind_of?(SpiderMonkey::RubyLandProxy)
          jsvalue = ruby.js
          FFI::MemoryPointer.new(:long).write_long(jsvalue)
        else
          jsvalue = make_js_land_proxy(ruby)
          FFI::MemoryPointer.new(:long).write_long(jsvalue)
        end
      end
    end

    def convert_to_ruby(js)

      return nil if js == SpiderMonkey::JSVAL_NULL

      case SpiderMonkey.JS_TypeOfValue(context, js)
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
        if js_value_is_proxy?(js)
          unwrap_js_land_proxy(js)
        else
          SpiderMonkey::RubyLandProxy.make_ruby_land_proxy(self, js)
        end
      when SpiderMonkey::JSTYPE_STRING
        convert_js_string_to_ruby(SpiderMonkey.JS_ValueToString(context, js))
      when SpiderMonkey::JSTYPE_BOOLEAN
        js == SpiderMonkey::JSVAL_TRUE ? true : false
      end
    end

    def convert_js_string_to_ruby(str)
      str_ptr = SpiderMonkey.JS_GetStringBytes(str);
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

  end
end
