class SumOfMultiples
  def initialize(*items)
    @items = items
  end

  def to(level)
    sum = 0;
    rest = @items

    until rest.length.zero?
      item, *rest = rest
      mult = item

      next if mult == 0

      while mult < level
        sum += mult unless rest.any? { |r| mult % r == 0 }
        mult += item
      end
    end

    sum
  end
end
