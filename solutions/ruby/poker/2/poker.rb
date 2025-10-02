class Poker
  CATEGORIES = %i[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair one_pair high_card].freeze
  RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2].freeze

  HandScore = Struct.new(:category, :highs, :kickers) do
    def <=>(other)
      comparison = CATEGORIES.index(category) <=> CATEGORIES.index(other.category)
      return comparison unless comparison.zero?

      highs.zip(other.highs).each do |mine, others|
        comparison = mine <=> others
        return comparison unless comparison.zero?
      end

      kickers.zip(other.kickers).each do |mine, others|
        comparison = mine <=> others
        return comparison unless comparison.zero?
      end

      return 0
    end

    def ==(other)
      (self <=> other) == 0
    end

    def self.from(cards)
      sorted_ranks = cards.map { |card| RANKS.index(card[0...-1]) }
                    .sort

      # test straight
      straight = sorted_ranks.each_cons(2).all? { |a, b| b - a == 1 } || sorted_ranks == [0, 9, 10, 11, 12]  # sequential or low-ace

      sorted_ranks = [9, 10, 11, 12, 0] if sorted_ranks == [0, 9, 10, 11, 12] # reorder low-ace

      # test flush
      flush = cards.map { |card| card[-1] }.each_cons(2).all? { |a, b| a == b } # same suit

      # return straight and/or flush
      return HandScore.new(:straight_flush, sorted_ranks, []) if straight && flush
      return HandScore.new(:flush,          sorted_ranks, []) if flush
      return HandScore.new(:straight,       sorted_ranks, []) if straight

      ##
      # continue proccessign for others

      groups = sorted_ranks.chunk_while { |a, b| a == b }   # chunk same ranks together
                      .to_a
                      .sort { |a, b| b.length - a.length }  # sort by chunk size 

      case groups
      in [[a,_,_,_], kicker]
        HandScore.new(:four_of_a_kind, [a], kicker)
      in [[f,_,_], [h,_]]
        HandScore.new(:full_house, [f, h], [])
      in [[t,_,_], *kickers]
        HandScore.new(:three_of_a_kind, [t], kickers.flatten)
      in [[t,_], [p, _], kicker]
        HandScore.new(:two_pair, [t, p].sort, kicker)
      in [[o, _], *kickers]
        HandScore.new(:one_pair, [o], kickers.flatten)
      else
        HandScore.new(:high_card, sorted_ranks, [])
      end
    end
  end

  def initialize(hands)
    @hands = hands
  end

  def best_hand
    scores = @hands.map { |hand| HandScore.from(hand) }
    best = scores.min # lowest is best

    @hands.zip(scores)
            .select { |_, score| score == best }
            .map(&:first)
  end
end
