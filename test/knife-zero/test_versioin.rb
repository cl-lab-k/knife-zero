require "knife-zero/version"

class TC_Version < Test::Unit::TestCase
  test "returns version correctly" do
    assert_equal("1.4.0", Knife::Zero::VERSION)
  end
end
