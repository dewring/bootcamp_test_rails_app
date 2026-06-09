module AnimalCry
  class UndefindAnimalError < StandardError
  end
  def cry
    raise UndefindAnimalError, "You put undefined animal. It can't cry."
  end
end
