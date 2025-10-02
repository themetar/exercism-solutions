class Matrix
  attr_reader :rows, :columns

  def initialize(string)
    matrix = string.split("\n").map { |e| e.split(' ').map(&:to_i) }
    @rows = matrix
    @columns = matrix.inject([]) do |accumulator, row|
      row.each_with_index do |e, i|
        accumulator.push([]) if accumulator[i].nil?
        accumulator[i].push(e)
      end
      accumulator
    end
  end

end
