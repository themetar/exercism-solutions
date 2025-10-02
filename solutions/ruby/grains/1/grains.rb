class Grains
  def self.square(index)
    raise ArgumentError.new("Square index #{index} is out of bounds.") if !index.between?(1, 64)

    1 << (index - 1)
  end

  def self.total
    (1 << 64) - 1
  end
end
