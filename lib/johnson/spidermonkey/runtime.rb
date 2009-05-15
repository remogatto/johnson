module Johnson
  module SpiderMonkey

    def self.runtimes
      @runtimes ||= []
    end

    at_exit do

      runtimes.each do |rt|
        rt.destroy
        SpiderMonkey.JS_ShutDown
      end

    end

    class Runtime

      CONTEXT_MAP_KEY = :johnson_context_map

      attr_reader :global, :gc_zeal

      include HasPointer, Conversions, JSLandProxy

      class << self
        def raise_js_exception(jsex)

          raise jsex if Exception === jsex
          raise Johnson::Error.new(jsex.to_s) unless Johnson::SpiderMonkey::RubyLandProxy === jsex

          stack = jsex.stack rescue nil

          message = jsex['message'] || jsex.to_s
          at = "(#{jsex['fileName']}):#{jsex['lineNumber']}"
          ex = Johnson::Error.new("#{message} at #{at}")
          if stack
            js_caller = stack.split("\n").find_all { |x| x != '@:0' }
            ex.set_backtrace(js_caller + caller)
          else
            ex.set_backtrace(caller)
          end

          raise ex
        end
      end

      def initialize
        @ptr = SpiderMonkey.JS_NewRuntime(0x100000)

        @compiled_scripts = {}
        @debugger = nil
        @gcthings = {}
        @traps = []
        @gc_zeal = 0

        @global = SpiderMonkey.JS_GetGlobalObject(context)

        SpiderMonkey.runtimes << self
        self["Ruby"] = Object
      end

      def destroy
        contexts = (Thread.current[CONTEXT_MAP_KEY] ||= {})
        cx = contexts[self.object_id]
        SpiderMonkey.JS_DestroyContext(cx)
        SpiderMonkey.JS_DestroyRuntime(self)
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
        contexts = (Thread.current[CONTEXT_MAP_KEY] ||= {})
        contexts[self.object_id] ||= Context.new(self)
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

      def gc_zeal=(zeal)
        SpiderMonkey.JS_SetGCZeal(context, zeal)
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
        ok = SpiderMonkey.JS_ExecuteScript(context, global, js_script, js)
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

          if SpiderMonkey.JS_IsExceptionPending(context) == JS_TRUE
            SpiderMonkey.JS_GetPendingException(context, context.exception);
            SpiderMonkey.JS_ClearPendingException(context)
          end

          if context.has_exception?
            self.class.raise_js_exception(convert_to_ruby(context.exception.read_long))
          end
          
        end

        convert_to_ruby(rval.read_long)
      end

    end
  end
end

