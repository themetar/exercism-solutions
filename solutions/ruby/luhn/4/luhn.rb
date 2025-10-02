class Luhn
  def self.valid?(string)
    Luhn.new(string).valid?
  end

  def initialize(string)
    @luhn_string = string.delete(" ")
  end

  def valid?
    valid_form? && valid_sum?
  end

  private

  attr_reader :luhn_string

  def valid_form?
    luhn_string.length > 1 && luhn_string !~ (/\D/)
  end

  def valid_sum?
    (luhn_sum % 10).zero?
  end

  def reverse_digits
    luhn_string.reverse.chars.map(&:to_i)
  end

  def luhn_sum
    reverse_digits.each_slice(2).sum(0) do |a, b|
      b = b.to_i * 2
      b -= 9 if b > 9
      a + b
    end
  end
end
