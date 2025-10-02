class Item
  
  attr_reader :name, :sell_in, :quality

  def is_conjured?
    name.start_with? 'Conjured'
  end

  def update!
    self.quality -= 1
    self.quality -= 1 if sell_in < 1
    if is_conjured?
      self.quality -= 1
      self.quality -= 1 if sell_in < 1
    end
    self.quality = quality.clamp(0, 50)
    self.sell_in -= 1
    self.quality = 0 if is_conjured? && sell_in < 0
  end

  private
  
  attr_writer :name, :sell_in, :quality

  def initialize(name:, sell_in:, quality:)
    self.name = name
    self.sell_in = sell_in
    self.quality = quality
  end

end

module AgedBrie

  def update!
    self.quality += 1
    self.quality += 1 if sell_in < 1
    self.quality = quality.clamp(0, 50)
    self.sell_in -= 1
    self.quality = 0 if is_conjured? && sell_in < 0
  end

end

module BackstagePasses

  def update!
    self.quality += 1 unless is_conjured?
    self.quality += 1 if sell_in < 11
    self.quality += 1 if sell_in < 6
    self.quality = 0 if sell_in < 1
    self.quality = quality.clamp(0, 50)
    self.sell_in -= 1
    self.quality = 0 if is_conjured? && sell_in < 0
  end

end

module Sulfuras

  def update!
    if is_conjured?
      self.sell_in -= 1 
      self.quality = 0 if sell_in < 0
    end
  end

end

class GildedRose

  def initialize(items)
    @items = items
    @items.each do |item|
      case item.name
      when /Aged Brie/i then item.extend AgedBrie
      when /Backstage passes/i then item.extend BackstagePasses
      when /Sulfuras/i then item.extend Sulfuras
      end
    end
  end

  def update!
    @items.each(&:update!)
  end

end
