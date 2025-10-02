module Grid
  def self.saddle_points(input)
    maximums_by_row = input.map(&:max)

    minimums_by_column = input.transpose.map(&:min)

    saddles = []

    maximums_by_row.each_with_index do |max_row, i|
      minimums_by_column.each_with_index do |min_col, j|
        saddles << { "row" => i + 1, "column" => j + 1} if max_row == min_col
      end
    end

    saddles
  end
end