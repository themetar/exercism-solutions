class TwelveDays
  GIFTS = ["Drummers Drumming", "Pipers Piping", "Lords-a-Leaping",
            "Ladies Dancing", "Maids-a-Milking", "Swans-a-Swimming",
            "Geese-a-Laying", "Gold Rings", "Calling Birds",
            "French Hens", "Turtle Doves", "a Partridge in a Pear Tree"].reverse

  DAYS = ["first", "second", "third",
          "fourth", "fifth", "sixth",
          "seventh", "eighth", "ninth",
          "tenth", "eleventh", "twelfth"]

  COUNT = ["and", "two", "three",
            "four", "five", "six",
            "seven", "eight", "nine",
            "ten", "eleven", "twelve"]

  def self.song
    self.lines.join("\n")
  end

  def self.lines
    (0...DAYS.length).map { |i| self.line(i) }
  end

  def self.line(n)
    "On the %s day of Christmas my true love gave to me: %s.\n" % [DAYS[n], self.gifts(n)]
  end

  def self.gifts(n)
    if n > 0
      (COUNT[0..n]).zip(GIFTS[0..n]).map { |a| a.join(" ") }.reverse.join(", ")
    else
      GIFTS[0]
    end
  end
end
