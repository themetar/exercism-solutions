class ComplexNumber
  attr_reader :real, :imaginary

  def initialize(a, b = 0)
    @real = a
    @imaginary = b
  end

  def +(other)
    ComplexNumber.new(real + other.real, imaginary + other.imaginary)
  end

  def -(other)
    ComplexNumber.new(real - other.real, imaginary - other.imaginary)
  end

  def *(other)
    ComplexNumber.new(real * other.real - imaginary * other.imaginary, imaginary * other.real + real * other.imaginary)
  end

  def /(other)
    mult_with_conjugate = self * other.conjugate

    ComplexNumber.new(mult_with_conjugate.real.to_f / other.sqabs, mult_with_conjugate.imaginary.to_f / other.sqabs)
  end

  def sqabs
    (self * self.conjugate).real
  end

  def abs
    Math.sqrt(sqabs)
  end

  def conjugate
    ComplexNumber.new(real, -imaginary)
  end

  def exp
    ComplexNumber.new((Math.exp(real) * Math.cos(imaginary)), (Math.exp(real) * Math.sin(imaginary)))
  end

  def ==(other)
    real == other.real
    imaginary == other.imaginary
  end
end
