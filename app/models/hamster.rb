class Hamster < Animal
  def info
    animal_info = super
    animal_info[:type] = "Hamster"
    animal_info
  end
  def cry
    "와앙"
  end
end
