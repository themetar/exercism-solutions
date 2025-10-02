module FoodChain
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
    1.upto(7).map { |count| make_verse(VERSE, count) } .join("\n") << "\n" << make_verse(CODA, 1) 
  end

  def self.make_verse(data, count)
    verse = ''

    animals = data.take(count).reverse

    verse << "I know an old lady who swallowed a #{animals.first[:animal]}.\n"
    
    verse << animals.first[:rhyme] <<"\n" if count > 1

    animals.each_cons(2) do |current, why|
      verse << "She swallowed the #{current[:animal]} to catch the #{why[:animal]}#{why[:flourish] || ''}.\n"
    end

    verse << animals.last[:rhyme]; verse << "\n"
  end
end