module BeerSong
  FIRST_LINE = "%s bottle%s of beer on the wall, %s bottle%s of beer.\n"
  SECOND_LINE = "Take %s down and pass it around, %s bottle%s of beer on the wall.\n"
  LAST_LINE = "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

  def self.recite(bottles, verses)
    bottles.downto(bottles - verses).each_cons(2).with_object('') do |(bottles_before, bottles_after), song|
      count, s = stringify(bottles_before)
      song << FIRST_LINE % [count.capitalize, s, count, s]

      if bottles_after == -1
        song << LAST_LINE
      else
        it = bottles_before == 1 ? 'it' : 'one'
        count, s = stringify(bottles_after)
        song << SECOND_LINE % [it, count, s]
      end

      song << "\n"
    end .chomp!  # remove last extra newline
  end

  def self.stringify(bottles)
    [(bottles == 0 ? 'no more' : bottles).to_s,
      bottles == 1 ? '' : 's']
  end
end
