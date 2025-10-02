class Integer
  ROMAN = {
    1    => 'I',
    4    => 'IV',
    5    => 'V',
    9    => 'IX',
    10   => 'X',
    40   => 'XL',
    50   => 'L',
    90   => 'XC',
    100  => 'C',
    400  => 'CD',
    500  => 'D',
    900  => 'CM',
    1000 => 'M'
  }.freeze

  ROMAN_DECIMAL = ROMAN.keys.sort.reverse.freeze
  
  def to_roman
    ROMAN_DECIMAL.reduce(['', self]) do |(output, value), part|
      div, mod = value.divmod part
      [output + ROMAN[part] * div, mod]
    end .first
  end
end
