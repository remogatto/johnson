require File.expand_path(File.join(File.dirname(__FILE__), "/../../helper"))

module Johnson
  module SpiderMonkey

    class << self
      def JS_AddNamedRoot(context, value, name)
        value ? JS_TRUE : JS_FALSE
      end
      def raise_js_error_in_ruby(context)
        raise "ERROR!"
      end
    end

    class RootTest < Johnson::TestCase
      
      def setup
        @context = {}
        @root = Root.new(@context)
      end

      def test_root_accepts_block
        @root.root { }
      end

      def test_root_check_set_js_false_on_error
        
        def func_that_returns_js_false
          JS_FALSE
        end

        def func_that_returns_js_true
          JS_TRUE
        end

        retval = @root.root do |r|
          r.check { func_that_returns_js_false }
          r.check { func_that_returns_js_true }
        end

        assert_equal(JS_FALSE, retval)
      end

      def test_root_check_returns_result
        @root.root do |r|
          @result = r.check { "result" } 
        end
        assert_equal("result", @result)
      end

      def test_root_check_raises_js_error_in_ruby

        def func_that_returns_js_false
          JS_FALSE
        end

        assert_raise(RuntimeError) { @root.root(:ruby => true) { |r| r.check { func_that_returns_js_false } } }
      end
      
      def test_root_returns_js_false_if_check_fails

        def func_that_returns_js_false
          JS_FALSE
        end

        retval = @root.root do |r|
          r.check { func_that_returns_js_false }
          r.check { @called = func_that_returns_js_true }          
        end

        assert_equal(JS_FALSE, retval)
        assert(!@called)
      end

      # def test_root_returns_js_true_if_no_error

      #   def func_that_returns_js_true
      #     JS_TRUE
      #   end

      #   retval = @root.root do |r|
      #     r.check { func_that_returns_js_true }
      #     "last evaluated expression"
      #   end

      #   assert_equal(JS_TRUE, retval)
      # end

      def test_root_returns_last_evaluated_expression_if_no_error

        def func_that_returns_js_true
          JS_TRUE
        end

        retval = @root.root do |r|
          r.check { func_that_returns_js_true }
          "last evaluated expression"
        end

        assert_equal("last evaluated expression", retval)
      end

      def test_add_root
        value = FFI::MemoryPointer.new(:long)
        retval = @root.root { |r| r.add(value) }
        assert_equal(JS_TRUE, retval)

        value = nil
        retval = @root.root { |r| r.add(value) }
        assert_equal(JS_FALSE, retval)
      end
      
    end

  end
end

