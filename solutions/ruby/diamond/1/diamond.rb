module Diamond
  def self.make_diamond(letter)
    width =  2 * ('A'..letter).count - 1

    lines = ('A'.next..letter).each_with_object(['A']) do |current, lines|
      lines << current + ' ' * lines.last.length + current
    end
    
    lines.map! do |line|
      line
          .rjust((line.length + width) / 2, ' ')
          .ljust(width, ' ')
    end

    lines.concat lines[0...-1].reverse

    lines.join("\n") + "\n"
  end
end
