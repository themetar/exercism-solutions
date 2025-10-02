module EliudsEggs

  def self.bits(integer)
    return to_enum(:bits, integer) unless block_given?

    while integer > 0
      yield integer & 1
      integer >>= 1
    end
  end

  def self.egg_count(display_number)
    bits(display_number).sum
  end
end
