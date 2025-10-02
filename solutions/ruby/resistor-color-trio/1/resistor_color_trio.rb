class ResistorColorTrio
  COLORS = %w[black brown red orange yellow green blue violet grey white]

  PREFIXES = ['', 'kilo', 'mega', 'giga']

  attr_reader :label

  def initialize(color_bands)
    first_digit, second_digit, trailing_zeros = color_bands.map { |color| COLORS.index(color) }

    number_value = (first_digit * 10 + second_digit) * 10**trailing_zeros

    kilo_exponent = 0

    while number_value / 1000 > 0
      number_value /= 1000
      kilo_exponent += 1
    end

    @label = "Resistor value: #{number_value} #{PREFIXES[kilo_exponent]}ohms"
  end
end
