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

    attr_reader :category, :cards, :raw

    def <=>(other)
      comparison = CATEGORIES.index(category) <=> CATEGORIES.index(other.category)
      return comparison unless comparison.zero?

      cards <=> other.cards
    end

    private

    attr_writer :category, :cards, :raw

    def initialize(notations)
      self.raw = notations

      self.cards = notations.map(&Card.method(:new))

      tallied_ranks = cards.map(&:rank).tally

      cards.sort! { |a, b| (tallied_ranks[b.rank] <=> tallied_ranks[a.rank]) * 2 + (a <=> b) }

      # test straight
      if cards == LOW_ACE_STRAIGHT # low-ace
        straight = true
        cards.rotate! # reorder low-ace
      end
      
      straight ||= cards.each_cons(2).all? { |a, b| a.rank.succ == b.rank } # sequential straight

      # test flush
      flush = cards.each_cons(2).all? { |a, b| a.suit == b.suit } # same suit

      # return straight and/or flush
      return self.category = :straight_flush if straight && flush
      return self.category = :flush if flush
      return self.category = :straight if straight

      ##
      # continue proccessing for others

      self.category = case cards
        in [k, ^k, ^k, ^k,  _] then :four_of_a_kind
        in [f, ^f, ^f,  h, ^h] then :full_house
        in [t, ^t, ^t,  _,  _] then :three_of_a_kind
        in [t, ^t,  p, ^p,  _] then :two_pair
        in [o, ^o,  _,  _,  _] then :one_pair
        else :high_card
        end
    end
  
  end

  def initialize(hands)
    @hands = hands.map(&Hand.method(:new))
  end

  def best_hand
    @hands.sort!

    @hands.take_while { |hand| hand == @hands.first }
          .map(&:raw)
  end
end
