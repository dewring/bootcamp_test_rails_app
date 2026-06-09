class Animal
  class UndefindAnimalNameError < StandardError
  end

  class UndefindAnimalColorError < StandardError
  end

  include AnimalCry
  include Describable
  def initialize(name, color)
    @name = name
    @color = color
    raise UndefindAnimalNameError, "You put wrong values." if @name.nil?
    raise UndefindAnimalColorError, "You put wrong values." if @color.nil?
  end
  def info
    {
      name: @name,
      color: @color
    }
  end
end
