module OcrNumbers
  FONT_WIDTH = 3
  FONT_HEIGHT = 4

  DIGITS = [" _     _  _     _  _  _  _  _ ",
            "| |  | _| _||_||_ |_   ||_||_|",
            "|_|  ||_  _|  | _||_|  ||_| _|",
            "                              "]
  
  def self.convert(input)
    strings = input.split("\n")

    raise ArgumentError unless valid_size?(strings)

    strings.each_slice(FONT_HEIGHT).map do |line_strings|
      (line_strings.first.length / FONT_WIDTH).times.inject('') do |text, caret|
        image = carve_section(caret, line_strings)
        digit = (0..9).find { |d| carve_section(d, DIGITS) == image }
        text + (digit || '?').to_s
      end
    end.join(',')
  end

  private

    def self.valid_size?(strings)
      strings.length % FONT_HEIGHT == 0 && strings.all? { |str| str.length % FONT_WIDTH == 0 }
    end

    def self.carve_section(offset, strings)
      strings.map { |str| str[offset * FONT_WIDTH, FONT_WIDTH] }
    end
end