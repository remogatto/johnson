module Johnson
  module SpiderMonkey
    class Runtime

      include HasPointer, Conversions, JSLandProxy

      def initialize
        @ptr = SpiderMonkey.JS_NewRuntime(0x100000)

        @compiled_scripts = {}
        @debugger = nil
        @gcthings = {}
        @traps = []

        self["Ruby"] = Object
      end

      def evaluate(script, filename = nil, linenum = nil)
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
        SpiderMonkey.JS_GetGlobalObject(context)
      end

      def has_global?
        not (@global.nil? or global.null?)
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

      def init_context
        Context.new(self)
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

