class Proverb
  attr_accessor :items, :options

  def initialize(*items)
    @options = items.last.is_a?(Hash) ? items.pop : {}
    @items = items
  end

  def to_s
    qualifier = options[:qualifier]
    verses = items.each_cons(2).map { |item_a, item_b| "For want of a #{item_a} the #{item_b} was lost." }
    verses << "And all for the want of a #{qualifier && qualifier + " "}#{items.first}."
    verses.join("\n")
  end
end
