module BottleSong
  BOTTLES_WALL = "%{amount} green %{noun} hanging on the wall"

  VERSE = "%{current},\n" * 2 +
          "And if one green bottle should accidentally fall,\n" +
          "There'll be %{future}.\n"

  AMOUNTS = %w[ no one two three four five six seven eight nine ten ]

  PLURALIZE = Proc.new { |count, noun| count == 1 ? noun : noun + "s" }

  def self.recite(from, count)
    from.downto(0).take(count + 1)
      .map { |bottles| BOTTLES_WALL % {amount: AMOUNTS[bottles], noun: PLURALIZE[bottles, "bottle"]} }
      .each_cons(2).map { |current, future| VERSE % {current: current.capitalize, future: future} }
      .join("\n")
  end
end