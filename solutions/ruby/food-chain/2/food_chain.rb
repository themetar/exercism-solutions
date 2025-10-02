class FoodChain
  VERSE = [
    {animal: 'fly', rhyme: "I don't know why she swallowed the fly. Perhaps she'll die."},
    {animal: 'spider', rhyme: "It wriggled and jiggled and tickled inside her.", flourish: " that wriggled and jiggled and tickled inside her"},
    {animal: 'bird', rhyme: "How absurd to swallow a bird!"},
    {animal: 'cat', rhyme: "Imagine that, to swallow a cat!"},
    {animal: 'dog', rhyme: "What a hog, to swallow a dog!"},
    {animal: 'goat', rhyme: "Just opened her throat and swallowed a goat!"},
    {animal: 'cow', rhyme: "I don't know how she swallowed a cow!"}
  ]

  CODA = [
    {animal: 'horse', rhyme: "She's dead, of course!"}
  ]

  def self.song
    new(VERSE).song
    .<< "\n"
    .<< new(CODA).song
  end

  def song
    (1..data.length).map(&method(:make_verse)).join("\n")
  end

  private

  attr_reader :data
  
  def initialize(data)
    @data = data
  end

  def make_verse(count)
    verse = ''

    food = data.take(count).reverse

    verse << "I know an old lady who swallowed a #{food.first[:animal]}.\n"
    
    verse << "#{food.first[:rhyme]}\n" if count > 1

    food.each_cons(2) do |current, why|
      verse << "She swallowed the #{current[:animal]} to catch the #{why[:animal]}#{why[:flourish]}.\n"
    end

    verse << food.last[:rhyme]
    verse << "\n"
  end
end