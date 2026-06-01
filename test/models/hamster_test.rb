require "test_helper"

class HamsterTest < ActiveSupport::TestCase
  test "#info ensure put name, color and type of animal." do
    hamster = Hamster.new("hamster", "white")
    assert_equal({ name: "hamster", color: "white", type: "Hamster" }, hamster.info)
  end
  test "#cry ensure cry when you put right info." do
    hamster = Hamster.new("hamster", "white")
    assert_equal("와앙", hamster.cry)
  end
end
