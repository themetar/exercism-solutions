class Knapsack
  attr_reader :capacity

  def max_value(items)
    return 0 if items.empty?
      
    table = Array.new(items.length) { Array.new(capacity + 1, 0) }
 
    items.each.with_index do |item, item_id|
      (0..capacity).each do |fill_to|
        without_item = table.dig(item_id - 1, fill_to)  # note: for the 0th item, dig reads table[-1], the last row, which is conveniently filled with zeros.
        with_item = item.weight > fill_to ? 0 : table.dig(item_id - 1, fill_to - item.weight) + item.value
        table[item_id][fill_to] = [with_item, without_item].max
      end
    end

    table.last.last
  end

  private

  def initialize(capacity)
    @capacity = capacity
  end
end
