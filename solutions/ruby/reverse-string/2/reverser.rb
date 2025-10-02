module Reverser
  def self.reverse(string)    
    string.each_char.with_object('') { |char, reversed| reversed.prepend(char) }
  end
end
