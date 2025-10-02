module Pangram
  ALPHABET_COUNT = 26
  
  def self.pangram?(sentence)
    sentence.downcase.chars.uniq.count { |char| char in 'a'..'z' } == ALPHABET_COUNT
  end
end
