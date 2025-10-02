class SpiralMatrix
  attr_reader :matrix
  
  def initialize(size)
    @matrix = generate(size)
  end

  private

    def generate(size)
      matrix = []
      numbers = (1..(size ** 2)).to_a

      while numbers.length > 0
        len = [matrix.length, 1].max
        matrix = rotate_right(matrix)
        row = numbers.pop(len)
        matrix.unshift(row)
      end

      matrix
    end

    def rotate_right(matrix)
      matrix.transpose.each { |r| r.reverse! }
    end
end