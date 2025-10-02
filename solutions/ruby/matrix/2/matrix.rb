class Matrix
  attr_reader :rows, :columns

  def initialize(string)
    @rows = string.lines.map { |line| line.scan(/\d+/).map(&:to_i) }
    @columns = @rows.first.map { |a| [a] }
    @rows.drop(1).each do |row|
      @columns.zip(row) { |col, item| col.push(item) }
    end
  end
end
