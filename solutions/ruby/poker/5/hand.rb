require_relative 'card'

class Poker

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

      self.category = decide_category!
    end

    def decide_category!
      # test low-ace straight
      if cards == LOW_ACE_STRAIGHT
        straight = true
        cards.rotate! # reorder low-ace: the ace is last place, not first
      end

      # test sequential straight
      straight ||= cards.each_cons(2).all? { |a, b| a.rank.succ == b.rank }

      # test flush
      flush = cards.each_cons(2).all? { |a, b| a.suit == b.suit }

      # return straight and/or flush
      return :straight_flush if straight && flush
      return :flush if flush
      return :straight if straight

      # test card ordering for others
      case cards
      in [k, ^k, ^k, ^k,  _] then :four_of_a_kind
      in [f, ^f, ^f,  h, ^h] then :full_house
      in [t, ^t, ^t,  _,  _] then :three_of_a_kind
      in [t, ^t,  p, ^p,  _] then :two_pair
      in [o, ^o,  _,  _,  _] then :one_pair
      else                        :high_card
      end
    end
  end

end
