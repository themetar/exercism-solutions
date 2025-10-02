module Reverser
  def self.reverse(string)    
    (1..string.length).map { |i| string[-i] }.join
  end
end
