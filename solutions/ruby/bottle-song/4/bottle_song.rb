module BottleSong

  AMOUNTS = %w[ no one two three four five six seven eight nine ten ]
  
  PLURALIZE = proc { |count, noun| count == 1 ? noun : noun + "s" }
  
  BOTTLES_TEMPLATE = "%{amount} green %{noun}"

  GREEN_BOTTLES = proc { |amount| BOTTLES_TEMPLATE % {amount: AMOUNTS[amount], noun: PLURALIZE[amount, "bottle"]} }

  VERSE_TEMPLATE = <<~VERSE
          %{current} hanging on the wall,
          %{current} hanging on the wall,
          And if one green bottle should accidentally fall,
          There'll be %{future} hanging on the wall.
          VERSE

  VERSE = proc { |current, future| VERSE_TEMPLATE % {current: current.capitalize, future: future} }

  def self.recite(from, count)
    from.downto(from - count)
        .map(&GREEN_BOTTLES)
        .each_cons(2).map(&VERSE)
        .join("\n")
  end

end