module FlowerField

  def self.annotate(input)
    input.map.with_index do |row, y|
      row.each_char.map.with_index  do |cell, x|
        next cell unless cell == ' '
  
        area = [*y-1..y+1].product [*x-1..x+1]
        area.reject! { |y, x| y < 0 || x < 0 || y >= input.length || x >= input[y].length }

        count = area.count { |y, x| input[y][x] == '*' }
        count.zero? ? ' ' : count
      end
      .join
    end
  end

end
