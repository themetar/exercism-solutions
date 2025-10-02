module IsbnVerifier
  def self.valid?(string)
    string = string.gsub('-', '')
    
    digits = string.each_char.with_object([]) do |char, digits|
      case char
      when ('0'..'9') then digits << char.to_i
      when 'X' then digits << 10
      else return false  # invalid character
      end
    end

    return false if digits.length != 10  # too long or too short

    pairs = 10.downto(1).to_a.zip(digits)

    return false if pairs.any? { |coef, digit| coef != 1 && digit == 10 }  # X where it doesn't belong 
    
    pairs.map { |coef, digit| coef * digit } .sum % 11 == 0
  end
end

    

    