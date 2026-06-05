class Alg
  def find_position(collection, find_value)
    current_position = 0
    for current_position in 0..collection.count
      if collection[current_position] == find_value
        return current_position
      end
    end
    nil
  end
end
