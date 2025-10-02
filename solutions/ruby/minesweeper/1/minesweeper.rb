module Minesweeper
  def self.annotate(field)
    height = field.length
    width = field.first&.length

    (0...height).each.map do |row_id|
      row_range = ((row_id - 1).clamp(0, height - 1))..((row_id + 1).clamp(0, height - 1))

      (0...width).each.with_object('') do |col_id, out_row|
        unless field[row_id][col_id] == ' '
          out_row << field[row_id][col_id]
        else
          col_range = ((col_id - 1).clamp(0, width - 1))..((col_id + 1).clamp(0, width - 1))

          mine_count = field[row_range].inject(0) { |mine_count, row| mine_count + row[col_range].count('*') }

          out_row << (mine_count > 0 ? mine_count.to_s : ' ')
        end
      end
    end
  end
end
