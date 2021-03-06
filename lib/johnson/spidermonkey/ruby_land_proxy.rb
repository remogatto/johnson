module Johnson
  module SpiderMonkey
    class RubyLandProxy
      include Enumerable
            
      # FIXME: need to revisit array vs non-array proxy, to_a/to_ary semantics, etc.

      alias_method :to_ary, :to_a
      attr_reader :js_value

      class << self

        protected :new

        def make_ruby_land_proxy(runtime, js)
          runtime.has_js_proxy?(js) ? runtime.get_js_proxy(js) : runtime.add_js_proxy(js, self.new(runtime, js))
        end

      end

      def initialize(runtime, js_value)
        @runtime = runtime
        @context = runtime.context
        @js_value = js_value
        @js_object = js_object
      end      

      def to_proc
        @proc ||= Proc.new { |*args| call(*args) }
      end

      def call(*args)
        call_using(@runtime.global_proxy, *args)
      end

      def call_using(this, *args)
        native_call(this, *args)
      end
      
      # def inspect
      #   toString
      # end

      def to_s
        @runtime.convert_js_string_to_ruby(SpiderMonkey.JS_ValueToString(@context, @js_value))
      end

      def [](name)
        get(name)
      end

      def []=(name, value)
        set(name, value)
      end

      def size
        length
      end

      def length
        length = FFI::MemoryPointer.new(:uint)
        if SpiderMonkey.JS_IsArrayObject(@context, @js_object) == JS_TRUE
          SpiderMonkey.JS_GetArrayLength(@context, @js_object, length)
          return length.read_int
        else
          ids = JSIdArray.new(SpiderMonkey.JS_Enumerate(@context, @js_object))
          length = ids[:length]
          SpiderMonkey.JS_DestroyIdArray(@context, ids);
          return length
        end
      end

      def each
        length = FFI::MemoryPointer.new(:uint)
        if SpiderMonkey.JS_IsArrayObject(@context, @js_object) == JS_TRUE
          SpiderMonkey.JS_GetArrayLength(@context, @js_object, length)
          (length.read_int).times do |i|
            element = FFI::MemoryPointer.new(:pointer)
            SpiderMonkey.JS_GetElement(@runtime.context, @js_object, i, element)
            yield @runtime.convert_to_ruby(element.read_long)
          end
        else
          js_value = FFI::MemoryPointer.new(:pointer)
          ids = JSIdArray.new(SpiderMonkey.JS_Enumerate(@context, @js_object))
          ids_ptr = ids.to_ptr
          ids[:length].times do |i|
            js_key = FFI::MemoryPointer.new(:pointer)
            SpiderMonkey.JS_IdToValue(@context, ids_ptr.get_int(4 + i*4) , js_key)
            if SpiderMonkey.JSVAL_IS_STRING(js_key.read_int)
              SpiderMonkey.JS_GetProperty(@context, @js_object,
                                          SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(@context, js_key.read_int)), 
                                          js_value)
            else
              SpiderMonkey.JS_GetElement(@context, 
                                         @js_object,
                                         SpiderMonkey.JSVAL_TO_INT(js_key.read_int), 
                                         js_value)
            end
            key = @runtime.convert_to_ruby(js_key.read_long)
            value = @runtime.convert_to_ruby(js_value.read_long)
            yield key, value
          end
        end
      end

      def method_missing(sym, *args, &block)
        args << block if block_given?
        
        name = sym.to_s
        assignment = "=" == name[-1, 1]

        # default behavior if the slot's not there

        return super unless assignment || respond_to?(sym)

        unless function_property?(name)
          # for arity 0, treat it as a get
          return self[name] if args.empty?

          # arity 1 and quacking like an assignment, treat it as a set
          return self[name[0..-2]] = args[0] if assignment && 1 == args.size
        end        
        
        # okay, must really be a function
        call_function_property(name, *args)
      end

      def respond_to?(sym)
        name = sym.to_s
        return true if sym.to_s.match(/=$/) # FIXME: this will also match 'foo=='
        found = FFI::MemoryPointer.new(:pointer)
        SpiderMonkey.JS_HasProperty(@context, @js_object, name, found)
        found.read_int == JS_TRUE ? true : super # FIXME: not sure why it works...
      end

      def function?
        SpiderMonkey.JS_TypeOfValue(@context, @js_value) == JSTYPE_FUNCTION ? true : false
      end

      def function_property?(name)
        js_rvalue = FFI::MemoryPointer.new(:pointer)
        SpiderMonkey.JS_GetProperty(@context, @js_object, name, js_rvalue)
        type = SpiderMonkey.JS_TypeOfValue(@context, js_rvalue.read_long);
        type == SpiderMonkey::JSTYPE_FUNCTION ? true : false
      end

      private

      def get(name)

        js_rvalue = FFI::MemoryPointer.new(:pointer)
        proxy_value = FFI::MemoryPointer.new(:long).write_long(@js_value)

        @runtime.context.root(:ruby => true) do |r|
          
          r.add(proxy_value)

          if name.kind_of?(Fixnum)
            r.check { SpiderMonkey.JS_GetElement(@context, @js_object, name, js_rvalue) }
          else
            r.check { SpiderMonkey.JS_GetProperty(@context, @js_object, name, js_rvalue) }
          end
          
          @runtime.convert_to_ruby(js_rvalue.read_long)

        end

      end

      def set(name, value)

        proxy_value = FFI::MemoryPointer.new(:long).write_long(@js_value)
        
        @runtime.context.root(:ruby => true) do |r|

          js_value = @runtime.convert_to_js(value)
          
          r.add(js_value)

          if name.kind_of?(Fixnum)
            r.check { SpiderMonkey.JS_SetElement(@context, @js_object, name, js_value) }
          elsif name.kind_of?(String)
            r.check { SpiderMonkey.JS_SetProperty(@context, @js_object, name, js_value) }
          else
            # FIXME: throw an exception?
          end

          value
        end

      end

      def native_call(this, *args)

        unless function?
          raise "This Johnson::SpiderMonkey::RubyLandProxy isn't a function."
        end

        js_result = FFI::MemoryPointer.new(:pointer)
        js_args = FFI::MemoryPointer.new(:long, args.size)

        @runtime.context.root(:ruby => true) do |r|

          if args.size > 0
            js_args.put_array_of_int(0, 
                                     args.map do |arg| 
                                       result = @runtime.convert_to_js(arg)
                                       r.add(result)
                                       result.read_long
                                     end
                                     )
          end
          
          js_value = @runtime.convert_to_js(this)

          r.add(js_value)

          js_object = FFI::MemoryPointer.new(:pointer)
          SpiderMonkey.JS_ValueToObject(@runtime.context, js_value.read_long, js_object)
          
          r.check { SpiderMonkey.JS_CallFunctionValue(@runtime.context, 
                                            js_object.read_pointer, 
                                            @js_value, 
                                            args.size, 
                                            js_args,
                                                      js_result) }
          

          @runtime.convert_to_ruby(js_result.read_long)

        end

      end

      def call_function_property(name, *args)
        get(name).call(*args)
      end

      def js_object
        js_object = FFI::MemoryPointer.new(:pointer)
        SpiderMonkey.JS_ValueToObject(@runtime.context, @js_value, js_object)
        js_object.read_pointer
      end

    end
  end
end
