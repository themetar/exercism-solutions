module Diamond
  def self.make_diamond(letter)
    width =  2 * (letter.ord - 'A'.ord) + 1

    lines = ["#{' ' * (width / 2)}A#{' ' * (width / 2)}"] +
            ('A'.next..letter).map do |current|
              inner = 2 * (current.ord - 'B'.ord) + 1
              outer = (width - inner - 2) / 2
              "#{' ' * outer}#{current}#{' ' * inner}#{current}#{' ' * outer}"
            end

    lines.concat lines.reverse.drop(1)

    lines.join("\n") + "\n"
  end
end
