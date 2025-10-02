Item = Struct.new(:name, :sell_in, :quality)

class GildedRose
  def initialize(items)
    @items = items
  end

  def update!
    @items.each do |item|
      case item.name
      when /Aged Brie/i
        item.quality += 1
        item.quality += 1 if item.sell_in < 1
        item.sell_in -= 1
      when /Backstage passes/i
        item.quality += 1
        item.quality -= 1 if is_conjured?(item)
        item.quality += 1 if item.sell_in < 11
        item.quality += 1 if item.sell_in < 6
        item.quality = 0 if item.sell_in < 1
        item.sell_in -= 1
      when /Sulfuras/i
        item.sell_in -= 1 if is_conjured?(item)
      else
        (is_conjured?(item) ? 2 : 1).times do
          item.quality -= 1
          item.quality -= 1 if item.sell_in < 1
        end
        item.sell_in -= 1
      end

      item.quality = 0 if is_conjured?(item) && item.sell_in < 0

      item.quality = item.quality.clamp(0, 50) unless /Sulfuras/i === item.name
    end
  end

  private

  def is_conjured?(item)
    item.name.start_with? 'Conjured'
  end
end
