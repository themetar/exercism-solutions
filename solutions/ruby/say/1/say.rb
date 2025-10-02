class Say
  MINIMUM = 0

  MAXIMUM = 999_999_999_999

  DIGITS = %w[zero one two three four five six seven eight nine].freeze

  TENS = %w[ten twenty thirty forty fifty sixty seventy eighty ninety].freeze

  TEENS = (%w[eleven twelve thirteen] + ["#{DIGITS[4]}teen", 'fifteen'] + (6..9).map { |d| "#{DIGITS[d]}teen" }).freeze

  SCALE_WORDS = ['', 'thousand', 'million', 'billion', 'trillion'].reverse.freeze

  def initialize(number)
    raise ArgumentError unless number.between?(MINIMUM, MAXIMUM)

    @number = number
  end

  def in_english
    if @number < 1000
      _in_english(@number)
    else
      chunks = chunk_number(@number)
      scales = SCALE_WORDS[-chunks.length..-1]
      chunks.map { |chunk| _in_english(chunk) }
            .zip(scales)
            .reject { |num, _| num == 'zero' }
            .flatten
            .join(' ')
            .rstrip
    end
  end

  private

    def _in_english(number)
      case true
      when (0..9).include?(number)
        DIGITS[number]
      when (11..19).include?(number)
        TEENS[number - 11]
      when (10..90).step(10).include?(number)
        TENS[number / 10 - 1]
      when (21..99).include?(number) 
        "#{_in_english(number / 10 * 10)}-#{_in_english(number % 10)}"
      when (100..999).include?(number)
        "#{_in_english(number / 100)} hundred#{number % 100 > 0 ? ' ' + _in_english(number % 100) : ''}"
      end
    end

    def chunk_number(number)
      loop.with_object([]) do |_, chunks|
        chunks << number % 1000
        number /= 1000
        break chunks.reverse if number.zero?        
      end
    end
end
