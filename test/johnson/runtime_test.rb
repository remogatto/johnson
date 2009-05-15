require File.expand_path(File.join(File.dirname(__FILE__), "/../helper"))
require 'tempfile'

module Johnson
  class RuntimeTest < Johnson::TestCase
    def setup
      @runtime = Johnson::Runtime.new
    end

    def test_default_delegate_is_ffi_spidermonkey
      assert_equal(Johnson::SpiderMonkey::Runtime, @runtime.delegate.class)
    end

    def test_evaluate_returns_nil_for_nil_expression
      assert_nil(@runtime.evaluate(nil))
    end

    def test_js_eval
      assert_equal(2, @runtime.evaluate('eval("1 + 1");'))
    end

    def test_shebang_removal
      t = Tempfile.new("johnson_shebang")
      t.open { |tf| tf.write "#!/usr/bin/johnson\ntrue;" }
      assert Johnson.load(t.path)
    end

    def test_js_throws_compile_errors
      assert_raises(Johnson::Error) {
        @runtime.evaluate("var js_lambda = function(x) { return x ** 2; }")
      }
      # assert_raises(Johnson::Error) {
      #   @runtime.compile("var js_lambda = function(x) { return x ** 2; }")
      # }
    end

    def test_global_is_a_ruby_proxy
      assert_kind_of(Johnson::SpiderMonkey::RubyLandProxy, @runtime.global)
    end

    def test_read_global
      @runtime.evaluate("var x = 123; x;")
      assert(123, @runtime['x'])
    end

    def test_write_global
      @runtime.global['x'] = 10
      assert_js_equal(10, 'x')
    end

#     def test_breakpoint_gets_called
#       break_times = 0
#       @runtime['some_number'] = 0
#       script = @runtime.compile("some_number++;
#                             var x = 0;
#                             for(var i = 0; i < 10; i++) {
#                               x++;
#                             }
#                             some_number++;
#                         ", 'awesome_script')
#       @runtime.break('awesome_script', 4) do
#         break_times += 1
#         assert_equal(@runtime['i'], @runtime['x'])
#         assert_equal(1, @runtime['some_number'])
#       end
#       @runtime.evaluate_compiled_script(script)
#       assert_equal(10, break_times)
#       assert_equal(2, @runtime['some_number'])
#     end

#     def test_try_to_gc
#       10.times {
#         thread = Thread.new do
#             rt = Johnson::Runtime.new
#             rt.evaluate('new Date()').to_s
#         end
#         thread.join
#         GC.start
#       }
#     end
  end
end
