class Transpose
  def self.transpose(text)
    lines = text.lines.collect(&:chomp)
    max_len = lines.collect(&:length).max
    lines.collect! { |line| line.ljust(max_len) }
    matrix = lines.collect {|line| line.split('')}
    matrix.transpose.collect(&:join).collect(&:rstrip).join("\n")
  end
end
