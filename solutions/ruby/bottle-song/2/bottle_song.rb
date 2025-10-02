module BottleSong
  BOTTLES_WALL = "%{amount} green %{noun} hanging on the wall"

  VERSE = "%{current},\n" * 2 +
          "And if one green bottle should accidentally fall,\n" +
          "There'll be %{future}.\n"

  AMOUNTS = %w[ no one two three four five six seven eight nine ten ]

  PLURALIZE = Proc.new { |count, noun| count == 1 ? noun : noun + "s" }

  def self.recite(from, count)
    from.downto(from - count)
      .map(&method(:bottles_hanging))
      .each_cons(2).map(&method(:verse))
      .join("\n")
  end

  def self.bottles_hanging(amount)
    BOTTLES_WALL % {amount: AMOUNTS[amount], noun: PLURALIZE[amount, "bottle"]}
  end

  def self.verse((current, future))
    VERSE % {current: current.capitalize, future: future}
  end
end