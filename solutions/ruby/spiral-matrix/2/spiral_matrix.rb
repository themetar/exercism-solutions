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
        matrix.unshift numbers.pop(len)
      end

      matrix
    end

    def rotate_right(matrix)
      matrix.reverse!.transpose
    end
end