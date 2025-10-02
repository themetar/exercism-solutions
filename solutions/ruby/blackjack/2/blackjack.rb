module Blackjack
  def self.parse_card(card)
    case card
    when 'ace' then 11
    when 'two' then 2
    when 'three' then 3
    when 'four' then 4
    when 'five' then 5
    when 'six' then 6
    when 'seven' then 7
    when 'eight' then 8
    when 'nine' then 9
    when 'ten', 'jack', 'queen', 'king' then 10
    else 0
    end
  end

  def self.card_range(card1, card2)
    value = parse_card(card1) + parse_card(card2)
    case value
    when (4..11) then 'low'
    when (12..16) then 'mid'
    when (17..20) then 'high'
    when 21 then 'blackjack'
    when 22 then 'aces'
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    hand = card_range(card1, card2)
    dealer_value = parse_card(dealer_card)

    case
    when hand == 'aces'
      'P'  # Split
    when hand == 'blackjack' && dealer_value < 10
      'W'  # Automatically win
    when hand == 'blackjack' || # implied dealer_value >= 10
         hand == 'high' ||
         hand == 'mid' && dealer_value < 7
      'S'  # Stand
    when hand == 'mid' || # implied dealer_value >= 7
         hand == 'low'
      'H'  # Hit
    end
  end
end
