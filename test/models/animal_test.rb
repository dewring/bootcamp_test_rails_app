require "test_helper"
class AnimalTest < ActiveSupport::TestCase
  test "#initialize second of value ensure put color of animal" do
    assert_raises Animal::UndefindAnimalColorError, "You put wrong values." do
      Animal.new("dog", nil)
    end
  end

  test "#initialize first of value ensure put name of animal" do
    assert_raises Animal::UndefindAnimalNameError, "You put wrong values." do
      Animal.new(nil, "brown")
    end
  end

  test "#info ensure put name and color of animal." do
    dog_animal = Animal.new("dog", "brown")
    assert_equal({ name: "dog", color: "brown" }, dog_animal.info)
    hamster_animal = Animal.new("hamster", "white")
    assert_equal({ name: "hamster", color: "white" }, hamster_animal.info)
  end

  test "#animal.animalcry ensure put defined animal" do
    assert_raises AnimalCry::UndefindAnimalError, "You put undefined animal. It can't cry." do
      Animal.new("dog", "brown").cry
    end
  end
end
