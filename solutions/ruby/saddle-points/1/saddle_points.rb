module Grid
  def self.saddle_points(input)
    maximums_by_row = input.map(&:max)

    minimums_by_column = input.transpose.map(&:min)

    saddles = []

    input.each_with_index do |row, i|
      row.each_with_index do |item, j|
        saddles << { "row" => i + 1, "column" => j + 1} if item >= maximums_by_row[i] && item <= minimums_by_column[j]
      end
    end

    saddles
  end
end