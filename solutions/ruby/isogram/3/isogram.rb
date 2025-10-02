module Isogram

  def self.isogram?(input)
    input.downcase.scan(/[a-z]/).then do |chars|
      chars.uniq.length == chars.length
    end
  end
  
end
