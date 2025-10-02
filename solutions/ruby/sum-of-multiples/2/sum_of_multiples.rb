class SumOfMultiples
  def initialize(*items)
    @items = items
  end

  def to(level)
    @items.each_with_object(Set.new) do |item, multiples|
      next if item.zero?
      multiples.merge((item...level).step(item))
    end
    .sum
  end
end
