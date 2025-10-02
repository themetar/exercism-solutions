class Proverb

  CHAIN_LINE = "For want of a %s the %s was lost."
  LAST_LINE = "And all for the want of a %s."

  private

  attr_accessor :items, :first_item

  def initialize(*items, qualifier: nil)
    self.items = items
    self.first_item = (qualifier ? qualifier + " " : '') + items.first
  end

  public

  def to_s
    verses = items.each_cons(2).map(&CHAIN_LINE.method(:%))
    verses << LAST_LINE % first_item
    verses.join("\n")
  end

end
