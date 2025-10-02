class Matrix
  attr_reader :rows, :columns

  def initialize(string)
    @rows = string.lines.map { |line| line.split.map(&:to_i) }
    @columns = @rows.transpose()
  end
end
