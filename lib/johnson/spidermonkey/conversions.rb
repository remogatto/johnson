module Johnson
  module Conversions

    def self.convert_to_js(runtime, ruby)
      if ruby.kind_of?(Fixnum)
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey.INT_TO_JSVAL(ruby))
        
      elsif ruby == true
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_TRUE)

      elsif ruby == false
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_FALSE)

      elsif ruby.kind_of?(Float) or ruby.kind_of?(Bignum)
        convert_float_or_bignum_to_js(runtime, ruby)

      elsif ruby.kind_of?(String)
        js_str_ptr = SpiderMonkey.JS_NewStringCopyN(runtime.context, ruby, ruby.size)
        jsvalue = SpiderMonkey.JS_StringToValue(runtime.context, js_str_ptr)
        FFI::MemoryPointer.new(:long).write_long(jsvalue)

      elsif ruby.nil?
        FFI::MemoryPointer.new(:long).write_long(SpiderMonkey::JSVAL_NULL)

      elsif ruby.kind_of?(Object) || ruby.kind_of?(Array)
        # FIXME: JSLandProxy should be a module
        if ruby.kind_of?(SpiderMonkey::RubyLandProxy)
          jsvalue = ruby.js
          FFI::MemoryPointer.new(:long).write_long(jsvalue)
        else
          jsvalue = SpiderMonkey::JSLandProxy.make_js_land_proxy(runtime, ruby)
          FFI::MemoryPointer.new(:long).write_long(jsvalue)
        end
      end
    end

    def self.convert_to_ruby(runtime, js)

      return nil if js == SpiderMonkey::JSVAL_NULL

      case SpiderMonkey.JS_TypeOfValue(runtime.context, js)
      when SpiderMonkey::JSTYPE_VOID
        nil
      when SpiderMonkey::JSTYPE_NUMBER
        if SpiderMonkey.JSVAL_IS_INT(js)
          SpiderMonkey.JSVAL_TO_INT(js)
        else
          rvalue = FFI::MemoryPointer.new(:double)
          SpiderMonkey.JS_ValueToNumber(runtime.context, js, rvalue)
          rvalue.get_double(0)
        end
      when SpiderMonkey::JSTYPE_OBJECT, SpiderMonkey::JSTYPE_FUNCTION
        if SpiderMonkey::JSLandProxy.js_value_is_proxy?(js)
          SpiderMonkey::JSLandProxy.unwrap_js_land_proxy(js)
        else
          SpiderMonkey::RubyLandProxy.make_ruby_land_proxy(runtime, js)
        end
      when SpiderMonkey::JSTYPE_STRING
        convert_js_string_to_ruby(runtime, SpiderMonkey.JS_ValueToString(runtime.context, js))
      when SpiderMonkey::JSTYPE_BOOLEAN
        js == SpiderMonkey::JSVAL_TRUE ? true : false
      end
    end

    def self.convert_js_string_to_ruby(runtime, str)
      str_ptr = SpiderMonkey.JS_GetStringBytes(str);
    end

    def raise_js_error_in_ruby(runtime)
    end

    def report_ruby_error_in_js(runtime, state, old_errinfo)
    end

    def self.convert_float_or_bignum_to_js(runtime, float_or_bignum)
      js = FFI::MemoryPointer.new(:long)
      SpiderMonkey.JS_NewNumberValue(runtime.context, float_or_bignum.to_f, js)
      js
    end

  end
end
