class Luhn
  def self.valid?(string)
    string = string.gsub(/\s+/, "")

    return false if string.length < 2
    return false if string.match?(/\D/)

    reverse_digits = string.reverse.chars.map(&:to_i)

    sum = reverse_digits.each_with_index.inject(0) do |accumulator, pair|
      digit, index = pair
      digit = digit * 2 if index.odd?
      digit = digit - 9 if digit > 9
      accumulator + digit
    end

    sum % 10 == 0
  end
end
