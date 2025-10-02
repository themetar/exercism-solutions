class Garden
  KIDS = [:alice, :bob, :charlie, :david,
          :eve, :fred, :ginny, :harriet,
          :ileana, :joseph, :kincaid, :larry]

  PLANTS = {'G' => :grass,
            'C' => :clover,
            'R' => :radishes,
            'V' => :violets}

  def initialize(cups)
    @cups = cups.lines

    raise ArgumentError, 'Invalid garden' unless @cups.length == 2
  end

  def method_missing(name, *args)
    index = KIDS.index(name)

    super unless index

    childs_cups = (@cups[0][index * 2, 2] || '').concat(@cups[1][index * 2, 2] || '')

    childs_cups.each_char.map { |letter| PLANTS[letter] }
  end
end
