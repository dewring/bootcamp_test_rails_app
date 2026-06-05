require "test_helper"
class AlgTest < ActiveSupport::TestCase
  test "#find_position should return the position of the element" do
    elements = [ "Jaina", "Leika", "Ellie", "Jade", "Litzi" ]
    assert_equal Alg.new.find_position(elements, "Ellie"), 2
  end

  test "#find_position should return nil if it doesnt exist" do
    elements = [ "Jaina", "Leika", "Ellie", "Jade", "Litzi" ]
    assert_nil Alg.new.find_position(elements, "Pitillo")
  end
end
