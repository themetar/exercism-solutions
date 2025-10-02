module BottleSong

  AMOUNTS = %w[ no one two three four five six seven eight nine ten ]
  
  PLURALIZE = proc { |count, noun| count == 1 ? noun : noun + "s" }
  
  BOTTLES_WALL = "%{amount} green %{noun} hanging on the wall"

  BOTTLES_HANGING = proc { |amount| BOTTLES_WALL % {amount: AMOUNTS[amount], noun: PLURALIZE[amount, "bottle"]} }

  VERSE = "%{current},\n" * 2 +
          "And if one green bottle should accidentally fall,\n" +
          "There'll be %{future}.\n"

  def self.recite(from, count)
    from.downto(from - count)
      .map(&BOTTLES_HANGING)
      .each_cons(2).map(&method(:verse))
      .join("\n")
  end

  def self.verse((current, future))
    VERSE % {current: current.capitalize, future: future}
  end

end