class Say

  MINIMUM = 0

  MAXIMUM = 999_999_999_999

  MAGNITUDES = {
    # 1_000_000_000_000 => 'trillion',
    1_000_000_000 => 'billion',
    1_000_000 => 'million',
    1_000 => 'thousand',
    100 => 'hundred'
  }

  NUMBERS = {
    0 => 'zero',
    1 => 'one',
    2 => 'two',
    3 => 'three',
    4 => 'four',
    5 => 'five',
    6 => 'six',
    7 => 'seven',
    8 => 'eight',
    9 => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seven',
    80 => 'eighty',
    90 => 'ninety'
  }

  NUMBERS.default_proc = proc do |hash, key|
    if key < 100
      remainder = key % 10
      hash[key] = "#{hash[key - remainder]}-#{hash[remainder]}"
    else
      magnitude, name = MAGNITUDES.find { |magnitude, _| key >= magnitude }
      number, remainder = key.divmod magnitude
      hash[key] = remainder.zero? ? "#{hash[number]} #{name}" : "#{hash[number]} #{name} #{hash[remainder]}"
    end
  end

  def initialize(number)
    raise ArgumentError unless number.between?(MINIMUM, MAXIMUM)

    @number = number
  end

  def in_english
    NUMBERS[@number]
  end

end
