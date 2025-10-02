class ResistorColorTrio
  COLORS = %w[black brown red orange yellow green blue violet grey white]

  PREFIXES = ['', 'kilo', 'mega', 'giga']

  def initialize(color_bands)
    @first_digit, @second_digit, @trailing_zeros = color_bands.map { |color| COLORS.index(color) }

    if @second_digit.zero?
      @trailing_zeros += 1
      @second_digit = @first_digit
      @first_digit = 0
    end
  end

  def label
    "Resistor value: #{to_s}"
  end

  def to_s
    number_value = @first_digit * 10 + @second_digit

    kilo_exponent = @trailing_zeros / 3
    rest_zeros = @trailing_zeros % 3

    "#{number_value}#{'0' * rest_zeros} #{PREFIXES[kilo_exponent]}ohms"
  end
end
