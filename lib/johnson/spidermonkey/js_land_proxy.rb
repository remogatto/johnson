module Johnson
  module SpiderMonkey
    module JSLandProxy #:nodoc:
      
      def js_land_class_proxy_class
        @js_land_class_proxy_class = JSClass.allocate
        @js_land_class_proxy_class.name = 'JSLandClassProxy'
        @js_land_class_proxy_class.addProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @js_land_class_proxy_class.delProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @js_land_class_proxy_class.getProperty = method(:get).to_proc
        @js_land_class_proxy_class.setProperty = method(:set).to_proc
        @js_land_class_proxy_class.enumerate = SpiderMonkey.method(:JS_EnumerateStub).to_proc
        @js_land_class_proxy_class.resolve =  SpiderMonkey.method(:JS_ResolveStub).to_proc
        @js_land_class_proxy_class.convert = SpiderMonkey.method(:JS_ConvertStub).to_proc
        @js_land_class_proxy_class.finalize = method(:finalize).to_proc
        @js_land_class_proxy_class.construct = method(:construct).to_proc
        @js_land_class_proxy_class
      end

      def js_land_proxy_class
        @js_land_proxy_class = JSClassWithNewResolve.allocate
        @js_land_proxy_class.name = 'JSLandProxy'
        @js_land_proxy_class.addProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @js_land_proxy_class.delProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @js_land_proxy_class.getProperty = method(:get).to_proc
        @js_land_proxy_class.setProperty = method(:set).to_proc
        @js_land_proxy_class.enumerate = SpiderMonkey.method(:JS_EnumerateStub).to_proc
        @js_land_proxy_class.resolve = method(:resolve).to_proc
        @js_land_proxy_class.convert = SpiderMonkey.method(:JS_ConvertStub).to_proc
        @js_land_proxy_class.finalize = method(:finalize).to_proc

        @js_land_proxy_class[:flags] = JSCLASS_NEW_RESOLVE

        @js_land_proxy_class
      end

      def js_land_callable_proxy_class
        @js_land_class_proxy_class = JSClass.allocate
        @js_land_class_proxy_class.name = 'JSLandCallableProxy'
        @js_land_class_proxy_class.addProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @js_land_class_proxy_class.delProperty = SpiderMonkey.method(:JS_PropertyStub).to_proc
        @js_land_class_proxy_class.getProperty = method(:get).to_proc
        @js_land_class_proxy_class.setProperty = method(:set).to_proc
        @js_land_class_proxy_class.enumerate = SpiderMonkey.method(:JS_EnumerateStub).to_proc
        @js_land_class_proxy_class.resolve =  SpiderMonkey.method(:JS_ResolveStub).to_proc
        @js_land_class_proxy_class.convert = SpiderMonkey.method(:JS_ConvertStub).to_proc
        @js_land_class_proxy_class.finalize = method(:finalize).to_proc
        @js_land_class_proxy_class.construct = method(:construct).to_proc
        @js_land_class_proxy_class.call = method(:call).to_proc
        @js_land_class_proxy_class
      end
      
      def add_proxy(js_value, ruby_value)
        add_js_proxy(js_value, ruby_value)
        add_ruby_proxy(ruby_value, js_value)
      end

      def add_js_proxy(js_value, ruby)
        (@js_proxies ||= { })[js_value] = ruby
      end

      def add_ruby_proxy(ruby, js_value)
        (@ruby_proxies ||= { })[ruby.object_id] = js_value
      end

      def has_ruby_proxy?(ruby)
        @ruby_proxies && @ruby_proxies.include?(ruby.object_id)
      end

      def has_js_proxy?(js_value)
        @js_proxies && @js_proxies.include?(js_value)
      end

      def get_ruby_proxy(ruby)
        @ruby_proxies[ruby.object_id]
      end

      def get_js_proxy(js_value)
        @js_proxies[js_value]
      end

      def make_js_land_proxy(ruby)

        if has_ruby_proxy?(ruby)
          get_ruby_proxy(ruby)
        else

          klass = if ruby.kind_of?(Class)
                    js_land_class_proxy_class
                  elsif ruby.respond_to?(:call)
                    js_land_callable_proxy_class
                  else
                    js_land_proxy_class            
                  end

          context.root do |r|

            js_object = r.check { SpiderMonkey.JS_NewObject(context, klass, nil, nil) }
            js_value = r.check { SpiderMonkey.JS_ObjectToValue(context, js_object) }

            r.add(js_object)

            r.check { SpiderMonkey.JS_DefineFunction(context, js_object, "__noSuchMethod__", method(:js_method_missing).to_proc, 2, 0) }
            r.check { SpiderMonkey.JS_DefineFunction(context, js_object, "toArray", method(:to_array).to_proc, 0, 0) }
            r.check { SpiderMonkey.JS_DefineFunction(context, js_object, "toString", method(:to_string).to_proc, 0, 0) }
          
            add_proxy(js_value, ruby)
            js_value

          end 

        end

      end
      
      def to_string(js_context, obj, argc, argv, retval)
        ruby = get_ruby(context, obj)
        retval.write_long(convert_to_js(ruby.to_s).read_long)         
        JS_TRUE
      end

      def to_array(js_context, obj, argc, argv, retval)
        ruby = @js_proxies[SpiderMonkey.JS_ObjectToValue(js_context, obj)]
        retval.write_long(convert_to_js(ruby.to_a).read_long)         
        JS_TRUE          
      end

      def js_method_missing(js_context, obj, argc, argv, retval)
        ruby = get_ruby(js_context, obj)
        args = argv.read_array_of_int(argc)
        args.collect! do |js_value|
          convert_to_ruby(js_value)
        end
        method_name = args[0]
        params = args[1].to_a
        send_with_possible_block(ruby, method_name, params)
        JS_TRUE
      end
      
      def js_value_is_proxy?(js_value)
        @js_proxies && @js_proxies.include?(js_value)
      end

      def unwrap_js_land_proxy(js_value)
        @js_proxies[js_value]
      end

      def js_respond_to?(js_context, obj, name)
        ruby = get_ruby(js_context, obj)

        autovivified?(ruby, name) || \
        constant?(ruby, name)     || \
        global?(name)             || \
        attribute?(ruby, name)    || \
        method?(ruby, name)       || \
        has_key?(ruby, name)
      end

      def global?(name)
        name.match(/^\$/) && global_variables.include?(name)
      end

      def constant?(target, name)
        target.kind_of?(Class) && target.constants.include?(name)
      end

      def method?(target, name)
        target.respond_to?(name.to_sym)          
      end
      
      def has_key?(target, name)
        target.respond_to?(:key?) or target.respond_to?(:[])
      end

      def resolve(js_context, obj, id, flags, objp)

        context.root do |r|

          name = SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(js_context, id))

          if js_respond_to?(js_context, obj, name)
            r.check do 
              SpiderMonkey.JS_DefineProperty(js_context, obj, name, JSVAL_VOID, method(:get_and_destroy_resolved_property).to_proc, 
                                             method(:set).to_proc, JSPROP_ENUMERATE)
            end
          end
          
          objp.write_pointer(obj)
          
          JS_TRUE
        end

      end

      def get_and_destroy_resolved_property(js_context, obj, id, retval)
        name = SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(js_context, id))

        context.root do |r|
          js_object = FFI::MemoryPointer.new(:long)
          SpiderMonkey.JS_ValueToObject(js_context, id, js_object)
          r.add(js_object.read_pointer)
          r.check { SpiderMonkey.JS_DeleteProperty(js_context, obj, name) }
          get(js_context, obj, id, retval)
          JS_TRUE
        end

      end

      def evaluate_js_property_expression(property, retval)
        SpiderMonkey.JS_EvaluateScript(context, 
                                       global,
                                       property, 
                                       property.size, 
                                       "johnson:evaluate_js_property_expression", 1,
                                       retval)
      end

      def get_ruby(context, obj)
        @js_proxies[SpiderMonkey.JS_ObjectToValue(context, obj)]
      end
      
      def get(js_context, obj, id, retval)
        name = SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(context, id))
        ruby = get_ruby(context, obj)

        context.root do |r|

          js_object = FFI::MemoryPointer.new(:long)
          SpiderMonkey.JS_ValueToObject(js_context, id, js_object)
          r.add(js_object.read_pointer)

          # Does this proxy refer to a ruby indexable object?
          if SpiderMonkey.JSVAL_IS_INT(id)
            idx = name.to_i
            if ruby.respond_to?(:[])
              retval.write_long(convert_to_js(ruby[idx]).read_long)
              return JS_TRUE
            end
          end
          
          if name == '__iterator__'
            evaluate_js_property_expression("Johnson.Generator.create", retval)
          
          elsif autovivified?(ruby, name)
            retval.write_long(convert_to_js(autovivified(ruby, name)).read_long)

            # Are we asking for a constant?
          elsif ruby.kind_of?(Class) && ruby.constants.include?(name)
            retval.write_long(convert_to_js(ruby.const_get(name)).read_long)

            # Are we asking for a global?
          elsif name.match(/^\$/) && global_variables.include?(name)
            retval.write_long(convert_to_js(eval(name)).read_long)

          elsif attribute?(ruby, name)
            retval.write_long(convert_to_js(ruby.send(name.to_sym)).read_long)

          elsif ruby.respond_to?(name.to_sym)
            retval.write_long(convert_to_js(ruby.method(name.to_sym)).read_long)

          elsif ruby.respond_to?(:key?) and ruby.respond_to?(:[])
            if ruby.key?(name)
              retval.write_long(convert_to_js(ruby[name]).read_long)
            end
          end

          JS_TRUE
        end
      end

      def set(js_context, obj, id, vp)

        name = SpiderMonkey.JS_GetStringBytes(SpiderMonkey.JS_ValueToString(context, id))
        ruby = get_ruby(context, obj)

        context.root do |r|

          js_object = FFI::MemoryPointer.new(:long)
          SpiderMonkey.JS_ValueToObject(js_context, id, js_object)
          r.add(js_object.read_pointer)

          if SpiderMonkey::JSVAL_IS_INT(id)
            idx = name.to_i
            if ruby.respond_to?(:[]=)
              ruby[idx] = convert_to_ruby(vp.read_long) 
            end

          elsif ruby.respond_to?(:[]=)
            ruby.send(:[]=, name, convert_to_ruby(vp.read_long))

          else
            autovivify(ruby, name, convert_to_ruby(vp.read_long))
          end        

          JS_TRUE
        end

      end

      def call_ruby_from_js(target, method, argc, argv, retval)

        args = argv.read_array_of_int(argc).collect do |js_value|
          convert_to_ruby(js_value)
        end

        begin
          ruby_result = send_with_possible_block(target, method, args)
        rescue Exception => ex
          report_ruby_error_in_js(ex)
          JS_FALSE
        end
        retval.write_long(convert_to_js(ruby_result).read_long).read_long

      end

      def call(js_context, obj, argc, argv, retval)
        callee = @js_proxies[SpiderMonkey.JS_ArgvCallee(argv)]

        context.root do |r|
          r.check { call_ruby_from_js(callee, :call, argc, argv, retval) }
          JS_TRUE
        end

      end

      # FIXME: not clear what to do here below ...
      def finalize(js_context, obj)
        js_value = SpiderMonkey.JS_ObjectToValue(js_context, obj)
        @js_proxies.delete(js_value)
        JS_TRUE
      end

      def construct(js_context, obj, argc, argv, retval)
        callee = @js_proxies[SpiderMonkey.JS_ArgvCallee(argv)]
        args = argv.read_array_of_int(argc).collect do |js_value|
          convert_to_ruby(js_value)
        end
        retval.write_long(convert_to_js(send_with_possible_block(callee, :new, args)).read_long)          
        JS_TRUE
      end
      
      def report_ruby_error_in_js(exception)
        js_value_ptr = convert_to_js(exception)
        SpiderMonkey.JS_SetPendingException(context, js_value_ptr.read_long)
      end

      def send_with_possible_block(target, symbol, args)
        block = args.pop if args.last.is_a?(RubyLandProxy) && args.last.function?
        target.__send__(symbol, *args, &block)
      end
      
      def treat_all_properties_as_methods(target)
        def target.js_property?(name); true; end
      end

      def attribute?(target, name)
        if target.respond_to?(name.to_sym)
          target.instance_variables.include?("@#{name}")
        end
      end      

      def js_property?(target, name)
        # FIXME: that rescue is gross; handles, e.g., "name?"
        (target.send(:instance_variable_defined?, "@#{name}") rescue false) ||
          (target.respond_to?(:js_property?) && target.__send__(:js_property?, name))
      end
      
      def call_proc_by_oid(oid, *args)
        id2ref(oid).call(*args)
      end
      
      def id2ref(oid)
        ObjectSpace._id2ref(oid)
      end
      
      def autovivified(target, attribute)
        target.send(:__johnson_js_properties)[attribute]
      end

      def autovivified?(target, attribute)
        target.respond_to?(:__johnson_js_properties) &&
          target.send(:__johnson_js_properties).key?(attribute)
      end

      def autovivify(target, attribute, value)
        (class << target; self; end).instance_eval do
          unless target.respond_to?(:__johnson_js_properties)
            define_method(:__johnson_js_properties) do
              @__johnson_js_properties ||= {}
            end
          end
          
          define_method(:"#{attribute}=") do |arg|
              send(:__johnson_js_properties)[attribute] = arg
            end
      
            define_method(:"#{attribute}") do |*args|
            js_prop = send(:__johnson_js_properties)[attribute]
              if js_prop.is_a?(RubyLandProxy) && js_prop.function?
                js_prop.call_using(self, *args)
              else
                js_prop
              end
            end
          end
          target.send(:"#{attribute}=", value)
        end
      
    end
  end
end
