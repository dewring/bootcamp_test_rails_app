class Dog < Animal
  def info
    animal_info = super
    animal_info[:type] = "Dog"
    animal_info
  end
  def cry
    "멍멍"
  end
end
