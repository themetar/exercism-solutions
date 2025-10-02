class Queens
  def initialize(white: [0, 3], black: [7, 3])
    raise ArgumentError if (white + black).any? { |i| i < 0 || i > 7 }
    
    @white_row, @white_col = white
    @black_row, @black_col = black
  end

  def attack?
    @white_row == @black_row ||
    @white_col == @black_col ||
    (@white_row - @black_row).abs == (@white_col - @black_col).abs
  end
end
