module Johnson
  module SpiderMonkey
    class Runtime
      def gc_callback(context, status)
        if status == JSGC_BEGIN
          ruby_runtime = JS_GetRuntimePrivate(JS_GetRuntime(context))
          return 1 if should_sm_gc?
        end
        return 0
      end
      def key_hash(ptr_key)
        ptr_key
      end
      def comparator(ptr_v1, ptr_v2)
        ptr_v1 == ptr_v2
      end
      def create_id_hash
        JS_NewHashTable(0, method(:key_hash).to_proc, method(:comparator).to_proc, method(:comparator).to_proc, nil, nil)  
      end
      def initialize_native(options)
        if @js = JS_NewRuntime(0x100000) && @jsids = create_id_hash && @rbids = create_id_hash
          # FIXME: How to get a pointer to self?
          JS_SetRuntimePrivate(@js, self);
          JS_SetGCCallbackRT(@js, method(:gc_callback).to_proc);
          if @global = JS_GetGlobalObject(johnson_get_current_context(runtime))
            return self
          end
          #clean up after an initialization failure
          JS_HashTableDestroy(@rbids) if @rbids
          JS_HashTableDestroy(@jsids) if @jsids
          JS_DestroyRuntime(@js) if @js
          raise "Couldn't initialize the runtime!")
        end
      end
    end
  end
end
