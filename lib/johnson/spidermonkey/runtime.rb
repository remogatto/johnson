module Johnson
  module SpiderMonkey
    class Runtime

      include Conversions, JSLandProxy

      def initialize
        @runtime = SpiderMonkey.JS_NewRuntime(0x100000)
        @compiled_scripts = {}
        @debugger = nil
        @gcthings = {}
        @traps = []

        SpiderMonkey.JS_SetErrorReporter(context, method(:report_error).to_proc)
        SpiderMonkey.JS_SetVersion(context, JSVERSION_LATEST)

        init_extensions
        self["Ruby"] = Object
      end

      def evaluate(script, filename=nil, linenum=nil)
        compile_and_evaluate(script, filename, linenum)

        # FIXME: in the final release the lines below should be
        # uncommented.

        # compiled_script = compile(script, filename, linenum)
        # evaluate_compiled_script(compiled_script)
      end

      def compile(script, filename=nil, linenum=nil)
        filename ||= 'none'
        linenum  ||= 1
        @compiled_scripts[filename] = native_compile(script, filename, linenum)
      end

      def context
        @context ||= init_context
      end

      def global
        @global ||= Global.new(context).to_ptr
      end

      def global_proxy
        @global_proxy ||= get_global_proxy
      end

      def [](key)
        global_proxy[key]
      end

      def []=(key, value)
        global_proxy[key] = value
      end

      private

      def report_error(context, message, report)
        ex = FFI::MemoryPointer.new(:long)
        ok = SpiderMonkey.JS_GetPendingException(context, ex)
        if ok == JS_TRUE
          exception = convert_to_ruby(ex.read_long)
          raise Error, exception['message']
        end
      end

      def init_context
        SpiderMonkey.JS_NewContext(@runtime, 8192)
      end

      def define_property(js_context, obj, argc, argv, retval)
        args = argv.get_array_of_int(0, argc)
        flags = argc > 3 ? SpiderMonkey.JSVAL_TO_INT(args[3]) : 0
        retval.write_long(JSVAL_VOID)
        name = SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(js_context, args[1]))    
        js_object = FFI::MemoryPointer.new(:pointer)
        SpiderMonkey.JS_ValueToObject(context, args[0], js_object)
        SpiderMonkey.JS_DefineProperty(js_context, js_object.read_pointer, name, argc > 2 ? args[2] : JSVAL_VOID, nil, nil, flags)
      end

      def init_extensions
        object = FFI::MemoryPointer.new(:long)
        object_ptr = FFI::MemoryPointer.new(:pointer)

        SpiderMonkey.JS_GetProperty(context, global, "Object", object)

        SpiderMonkey.JS_ValueToObject(context, object.read_long , object_ptr)

        SpiderMonkey.JS_DefineFunction(context, object_ptr.read_pointer,
                                       "defineProperty", 
                                       method(:define_property).to_proc, 4, 0)
        
        SpiderMonkey.JS_DefineProperty(context, object_ptr.read_pointer, 
                                       "READ_ONLY",
                                       SpiderMonkey.INT_TO_JSVAL(0x02), nil, nil, JSPROP_READONLY)
        
        SpiderMonkey.JS_DefineProperty(context, object_ptr.read_pointer, 
                                       "ITERABLE",
                                       SpiderMonkey.INT_TO_JSVAL(0x01), nil, nil, JSPROP_READONLY)
        
        SpiderMonkey.JS_DefineProperty(context, object_ptr.read_pointer, 
                                       "NON_DELETABLE",
                                       SpiderMonkey.INT_TO_JSVAL(0x04), nil, nil, JSPROP_READONLY)

      end

      def get_global_proxy
        jsval = SpiderMonkey.JS_ObjectToValue(context, global)
        convert_to_ruby(jsval)
      end

      def native_compile(script, filename, linenum)
        compiled_js = SpiderMonkey.JS_CompileScript(context, global, script, script.size, filename, linenum)
        script_object = SpiderMonkey.JS_NewScriptObject(context, compiled_js)
        jsval = SpiderMonkey.JS_ObjectToValue(context, script_object)
        convert_to_ruby(jsval)
      end

      def evaluate_compiled(js_script)
        evaluate_compiled_script(js_script)
      end

      def evaluate_compiled_script(js_script)
        js = FFI::MemoryPointer.new(:pointer)
        ok = JS_ExecuteScript(context, global, js_script, js)
        if ok == JS_TRUE
          convert_to_ruby(js.read_long)
        else
          raise "Error"
        end
      end

      def compile_and_evaluate(script, filename, linenum)
        filename ||= 'none'
        linenum  ||= 1
        rval = FFI::MemoryPointer.new(:long)
        ok = SpiderMonkey.JS_EvaluateScript(context, global, script, script.size, filename, linenum, rval)
        # FIXME: better exception handling here below
        if ok == JS_FALSE
          raise Error
        end
        convert_to_ruby(rval.read_long)
      end

    end
  end
end

