class Luhn
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
    @luhn_chars.length > 1 && @luhn_chars.all? { |c| ('0'..'9').include?(c) }
  end

  def valid_sum?
    reverse_digits = @luhn_chars.reverse.map(&:to_i)

    luhn_sum = reverse_digits.each_with_index.inject(0) do |accumulator, pair|
      digit, index = pair
      digit = digit * 2 if index.odd?
      digit = digit - 9 if digit > 9
      accumulator + digit
    end

    (luhn_sum % 10).zero?
  end
end
