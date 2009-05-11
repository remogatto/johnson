module Johnson
  module SpiderMonkey
    class Runtime

      include Conversions

      def initialize
        @runtime = SpiderMonkey.JS_NewRuntime(0x100000)
        @compiled_scripts = {}
        @debugger = nil
        @gcthings = {}
        @traps = []
        SpiderMonkey.JS_SetErrorReporter(context, method(:report_error).to_proc)
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
        @global ||= init_global
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
          exception = Conversions::convert_to_ruby(self, ex.read_long)
          raise Error, exception['message']
        end
      end

      def enumerate(js_context, obj)
        JS_EnumerateStandardClasses(js_context, obj)
      end

      def resolve(js_context, obj, id, flags, objp)
        if ((flags & JSRESOLVE_ASSIGNING) == 0)
          resolved_p = FFI::MemoryPointer.new(:int)
          if (!SpiderMonkey.JS_ResolveStandardClass(js_context, obj, id, resolved_p) == JS_TRUE)
             return JS_FALSE
          end
          if resolved_p.get_int(0) == JS_TRUE
            objp.write_pointer(obj)
          end
        end
        return JS_TRUE
      end

      def init_context
        SpiderMonkey.JS_NewContext(@runtime, 8192)
      end

      def init_global
        @global_class = JSClassWithNewResolve.allocate
        @global_class.name = 'global'
        @global_class[:flags] = JSCLASS_NEW_RESOLVE | JSCLASS_GLOBAL_FLAGS
        @global_class.addProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @global_class.delProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @global_class.getProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @global_class.setProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @global_class.enumerate = method(:enumerate).to_proc
        @global_class.resolve = method(:resolve).to_proc
        @global_class.convert = SpiderMonkey.method(:JS_ConvertStub).to_proc
        @global_class.finalize = SpiderMonkey.method(:JS_FinalizeStub).to_proc
        SpiderMonkey.JS_SetVersion(context, JSVERSION_LATEST)
        global = SpiderMonkey.JS_NewObject(context, @global_class.to_ptr, nil, nil)
        SpiderMonkey.JS_InitStandardClasses(context, global)
        global
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
        Conversions::convert_to_ruby(self, jsval)
      end

      def native_compile(script, filename, linenum)
        compiled_js = SpiderMonkey.JS_CompileScript(context, global, script, script.size, filename, linenum)
        script_object = SpiderMonkey.JS_NewScriptObject(context, compiled_js)
        jsval = SpiderMonkey.JS_ObjectToValue(context, script_object)
        Conversions::convert_to_ruby(self, jsval)
      end

      def evaluate_compiled(js_script)
        evaluate_compiled_script(js_script)
      end

      def evaluate_compiled_script(js_script)
        js = FFI::MemoryPointer.new(:pointer)
        ok = JS_ExecuteScript(context, global, js_script, js)
        if ok == JS_TRUE
          Conversions::convert_to_ruby(self, js.get_int(0))
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
        Conversions::convert_to_ruby(self, rval.read_long)
      end

    end
  end
end

