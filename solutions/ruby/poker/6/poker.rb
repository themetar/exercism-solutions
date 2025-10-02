require_relative 'hand'

class Poker

  def best_hand
    hands.sort!
         .take_while { |hand| hand == hands.first }
         .map(&:raw)
  end

  private

  attr_accessor :hands

  def initialize(hands)
    self.hands = hands.map(&Hand.method(:new))
  end

end
