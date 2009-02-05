module Johnson
  class SpiderMonkeyTest < Test::Unit::TestCase
    def test_version
      assert_not_nil Johnson::SpiderMonkey::VERSION
    end
  end
end
