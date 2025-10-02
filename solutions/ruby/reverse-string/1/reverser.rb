module Reverser
  def self.reverse(string)    
    string.each_char.reduce('') { |rev, char| char + rev }
  end
end
