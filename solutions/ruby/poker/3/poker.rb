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
    
  class Hand
    include Comparable

    CATEGORIES = %i[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair one_pair high_card]

    LOW_ACE_STRAIGHT = %w[A* 5* 4* 3* 2*].map(&Card.method(:new))

    attr_reader :category, :highs, :kickers, :raw

    def <=>(other)
      comparison = CATEGORIES.index(category) <=> CATEGORIES.index(other.category)
      return comparison unless comparison.zero?

      comparison = highs <=> other.highs
      return comparison unless comparison.zero?

      kickers <=> other.kickers
    end

    private

    attr_writer :category, :highs, :kickers, :raw

    def initialize(cards)
      self.raw = cards

      sorted = cards.map(&Card.method(:new))
                    .sort_by(&:rank)

      # test straight
      if sorted == LOW_ACE_STRAIGHT # low-ace
        straight = true
        sorted.rotate! # reorder low-ace
      end
      
      straight ||= sorted.each_cons(2).all? { |a, b| a.rank.succ == b.rank } # sequential straight

      # test flush
      flush = sorted.each_cons(2).all? { |a, b| a.suit == b.suit } # same suit

      # return straight and/or flush
      return setup(:straight_flush, sorted, []) if straight && flush
      return setup(:flush,          sorted, []) if flush
      return setup(:straight,       sorted, []) if straight

      ##
      # continue proccessing for others

      groups = sorted.chunk_while { |a, b| a == b }   # chunk same ranks together
                      .sort { |a, b| b.length - a.length }  # sort by chunk size 

      case groups
      in [[a,_,_,_], kicker]
        setup(:four_of_a_kind, [a], kicker)
      in [[f,_,_], [h,_]]
        setup(:full_house, [f, h])
      in [[t,_,_], *kickers]
        setup(:three_of_a_kind, [t], kickers.flatten)
      in [[t,_], [p, _], kicker]
        setup(:two_pair, [t, p].sort, kicker)
      in [[o, _], *kickers]
        setup(:one_pair, [o], kickers.flatten)
      else
        setup(:high_card, sorted)
      end
    end

    def setup(category, highs, kickers = [])
      self.category = category
      self.highs = highs
      self.kickers = kickers
    end
  
  end

  def initialize(hands)
    @hands = hands.map(&Hand.method(:new))
  end

  def best_hand
    @hands.sort!

    @hands.take_while { |hand| hand == @hands.first}
          .map(&:raw)
  end
end
