class Luhn
  attr_reader :luhn_chars

  def self.valid?(string)
    Luhn.new(string).valid?
  end

  def initialize(string)
    @luhn_chars = string.gsub(/\s+/, "").chars
  end

  def valid?
    valid_form? && valid_sum?
  end

  private

  def valid_form?
    luhn_chars.length > 1 && luhn_chars.all? { |c| ('0'..'9').include?(c) }
  end

  def valid_sum?
    (luhn_sum % 10).zero?
  end

  def reverse_digits
    luhn_chars.reverse.map(&:to_i)
  end

  def luhn_sum
    reverse_digits.each_with_index.collect do |digit, index|
      if index.odd?
        digit = digit * 2
        digit = digit - 9 if digit > 9
      end
      digit
    end .sum
  end
end
