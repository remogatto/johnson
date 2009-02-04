module Johnson
  class JavaScriptCoreTest < Test::Unit::TestCase
    def test_version
      assert_not_nil Johnson::JavaScriptCore::VERSION
    end
  end
end
