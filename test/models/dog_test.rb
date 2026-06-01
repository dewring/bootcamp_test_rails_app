require "test_helper"

class DogTest < ActiveSupport::TestCase
  test "#info ensure put name, color and type of animal." do
    dog = Dog.new("Dog", "white")
    assert_equal({ name: "Dog", color: "white", type: "Dog" }, dog.info)
  end
  self.test "#cry ensure cry when you put right info." do
    dog = Dog.new("Dog", "white")
    assert_equal("멍멍", dog.cry)
  end
end
