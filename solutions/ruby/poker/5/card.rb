class Poker

  class Card
    include Comparable

    RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2]

    attr_reader :rank, :suit

    def <=>(other)
      rank <=> other.rank
    end

    private

    attr_writer :rank, :suit

    def initialize(notation)
      self.rank = RANKS.index(notation[0...-1])
      self.suit = notation[-1]
    end

  end

end
