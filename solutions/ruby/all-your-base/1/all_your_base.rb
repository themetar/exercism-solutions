module BaseConverter
  def self.convert(input_base, digits, output_base)
    to_base(from_base(input_base, digits), output_base)
  end

  def self.from_base(base, digits)
    raise ArgumentError if base < 2

    raise ArgumentError if digits.any? { |digit| digit < 0 || digit >= base }

    digits.reduce(0) { |acc, digit| acc * base + digit }
  end

  def self.to_base(number, base)
    raise ArgumentError if base < 2
    
    loop.with_object([]) do |_, output|
      number, digit = number.divmod base
      output.unshift digit
      break output unless number > 0
    end
  end
end
