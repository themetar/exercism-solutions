class SumOfMultiples
  def initialize(*items)
    @items = items
  end

  def to(level)
    @items.reject(&:zero?)
          .map { |item| (item...level).step(item) }
          .reduce(Set.new, &:|)
          .sum
  end
end
