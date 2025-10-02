class Transpose
  def self.transpose(text)
    lines = text.lines.map(&:chomp)
    
    max_len = lines.map(&:length).max || 0
  
    columns = max_len.times.map do |col|
      lines.each_with_index.reduce([]) do |column, (line, row)|
        if line[col]
          column + [' '] * (row - column.length) + [line[col]]
        else
          column
        end
      end
    end

    columns.map { |column| column.join }.join("\n")
  end
end
