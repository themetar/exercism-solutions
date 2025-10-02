module TwelveDays
  GIFTS = ["a Partridge in a Pear Tree", "two Turtle Doves", "three French Hens",
            "four Calling Birds",  "five Gold Rings", "six Geese-a-Laying",
            "seven Swans-a-Swimming", "eight Maids-a-Milking", "nine Ladies Dancing",
            "ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming"]

  COMPOUNDED_GIFTS = GIFTS.each_with_object([]) do |added_gift, list|
    compounded = list.last
    compounded = ",#{list.size == 1 ? " and" : ""} #{compounded}" unless list.size.zero?
    compounded = "#{added_gift}#{compounded}"
    list << compounded
  end

  NTH = ["first", "second", "third",
          "fourth", "fifth", "sixth",
          "seventh", "eighth", "ninth",
          "tenth", "eleventh", "twelfth"]

  LINE_PATTERN = "On the %s day of Christmas my true love gave to me: %s.\n"

  def self.song
    NTH.zip(COMPOUNDED_GIFTS)
       .map(&LINE_PATTERN.method(:%))
       .join("\n")
  end    

end
