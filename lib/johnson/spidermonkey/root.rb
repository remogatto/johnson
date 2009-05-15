module Johnson
  module SpiderMonkey

    class Root

      def initialize(context)
        @context = context
      end

      def root(options = {}, &blk)
        @roots = {}
        @root_ruby = true if options[:ruby]

        last_evaluated = yield self

        remove_roots
        
        if @retval.kind_of?(FFI::Pointer)
          last_evaluated
        else
          @retval == JS_FALSE ? @retval : last_evaluated
        end

      end

      def add(value, name = "")
        name = sprintf("%s[%d]:%s: %s", __FILE__, __LINE__, __method__, value.inspect) if name.empty?
        check { SpiderMonkey.JS_AddNamedRoot(@context, value, name) }
      end

      def check(&blk)
        
        if sanitize(@retval) != JS_FALSE

          cond = blk.call

          if sanitize(cond) == JS_FALSE
            remove_roots
            if @root_ruby
              SpiderMonkey.raise_js_error_in_ruby(@context)
            else
              @retval = JS_FALSE
            end
          else
            @retval = cond
          end
        end

      end

      def remove_roots
        @roots.each do |root|
          SpiderMonkey.JS_RemoveRoot(@context, root)
        end
        @roots.clear
      end

      private

      def sanitize(cond)
        if cond.kind_of?(FFI::Pointer)
          return JS_FALSE if cond.null?
        else
          cond
        end
      end

      # def prepare_roots(options = {})
      #   options[:ruby] ? @_root_ruby = true : @_root_ruby = false
      #   @roots = []
      # end

      # def root(value, name = "", options = {})
      #   name = "noname" if name.empty?
      #   return JS_FALSE unless check(SpiderMonkey.JS_AddNamedRoot(self, value, name))
      #   (@roots ||= []) << value
      # end

      # def remove_roots
      #   @roots.each do |root|
      #     SpiderMonkey.JS_RemoveRoot(self, root)
      #   end
      #   @roots.clear
      # end

      # def sanitize(cond)
      #   if cond.kind_of?(FFI::Pointer)
      #     return JS_FALSE if cond.null?
      #   else
      #     cond
      #   end
      # end

      # def check(cond)
      #   if sanitize(cond) == JS_FALSE
      #     remove_roots
      #     if @_root_ruby
      #       raise_js_error_in_ruby
      #     else
      #       return false
      #     end
      #   else
      #     return true
      #   end
      # end

    end
  end
end
