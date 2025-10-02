class Matrix
  attr_reader :rows, :columns

  def initialize(string)
    @rows = string.lines.map { |line| line.split.map(&:to_i) }
    @columns = @rows.transpose()
  end

  def row(r)
    @rows[r - 1]
  end

  def column(c)
    @columns[c - 1]
  end
end
