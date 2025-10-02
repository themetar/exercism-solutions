class Scrabble

  @@points_for = Proc.new do |letter|
    case letter.downcase
    when 'a', 'e', 'i', 'o', 'u', 'l', 'n', 'r', 's', 't' then 1
    when 'd', 'g'                                         then 2
    when 'b', 'c', 'm', 'p'                               then 3
    when 'f', 'h', 'v', 'w', 'y'                          then 4
    when 'k'                                              then 5
    when 'j', 'x'                                         then 8
    when 'q', 'z'                                         then 10
    else
      0
    end
  end

  def self.score(word)
    word.to_s.chars.map(&@@points_for).reduce(0, &:+)
  end

  def initialize(word)
    @word = word
  end

  def score
    Scrabble.score(@word)
  end

end
