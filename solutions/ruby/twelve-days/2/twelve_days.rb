class TwelveDays
  GIFTS = ["twelve Drummers Drumming", "eleven Pipers Piping", "ten Lords-a-Leaping",
            "nine Ladies Dancing", "eight Maids-a-Milking", "seven Swans-a-Swimming",
            "six Geese-a-Laying", "five Gold Rings", "four Calling Birds",
            "three French Hens", "two Turtle Doves", "a Partridge in a Pear Tree"].reverse

  DAYS = ["first", "second", "third",
          "fourth", "fifth", "sixth",
          "seventh", "eighth", "ninth",
          "tenth", "eleventh", "twelfth"]

  def self.song
    TwelveDays.new.lines.join("\n")
  end

  def lines
    (0...DAYS.length).map { |i| line(i) }
  end

  def line(n)
    "On the %s day of Christmas my true love gave to me: %s.\n" % [DAYS[n], gifts(n)]
  end

  def gifts(n)
    if n > 0
      GIFTS[1..n].reverse.join(", ") + ", and " + GIFTS.first
    else
      GIFTS.first
    end
  end
end
