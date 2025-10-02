class Poker

  class Hand
    include Comparable

    RANKS = %w[A K Q J 10 9 8 7 6 5 4 3 2]

    CATEGORIES = %i[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair one_pair high_card]

    LOW_ACE_STRAIGHT = %w[A 5 4 3 2].map(&RANKS.method(:index))

    attr_reader :category, :ranks, :raw

    def <=>(other)
      comparison = CATEGORIES.index(category) <=> CATEGORIES.index(other.category)
      return comparison unless comparison.zero?

      ranks <=> other.ranks
    end

    private

    attr_writer :category, :ranks, :raw
    attr_accessor :is_flush

    def initialize(notations)
      self.raw = notations

      self.is_flush = notations.map { |notation| notation[-1] }.then { |suits| suits.all?(suits.first) }

      self.ranks = notations.map { |notation| RANKS.index(notation[0...-1]) }
      tallied_ranks = ranks.tally
      ranks.sort! { |a, b| (tallied_ranks[b] <=> tallied_ranks[a]) * 2 + (a <=> b) }

      self.category = decide_category!
    end

    def decide_category!
      case ranks
      in [k, ^(k + 1), ^(k + 2), ^(k + 3), ^(k + 4)] 
        is_flush ? :straight_flush : :straight
      in LOW_ACE_STRAIGHT
        ranks.rotate! # reorder low-ace: the ace is last place, not first
        is_flush ? :straight_flush : :straight
      in _ if is_flush       then :flush
      in [k, ^k, ^k, ^k,  _] then :four_of_a_kind
      in [f, ^f, ^f,  h, ^h] then :full_house
      in [k, ^k, ^k,  _,  _] then :three_of_a_kind
      in [t, ^t,  p, ^p,  _] then :two_pair
      in [k, ^k,  _,  _,  _] then :one_pair
      else                        :high_card
      end
    end

  end

end
