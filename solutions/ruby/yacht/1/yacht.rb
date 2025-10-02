class Yacht
  MATCH = {
    "ones" => ->(_) { true },
    "twos" => ->(_) { true },
    "threes" => ->(_) { true },
    "fours" => ->(_) { true },
    "fives" => ->(_) { true },
    "sixes" => ->(_) { true },
    "full house" => ->(dice) { dice.tally.values.sort == [2, 3] },
    "four of a kind" => ->(dice) { dice.tally.values.max >= 4 },
    "little straight" => ->(dice) { dice.sort == [1, 2, 3, 4, 5] },
    "big straight" => ->(dice) { dice.sort == [2, 3, 4, 5, 6] },
    "choice" => ->(_) { true },
    "yacht" => ->(dice) { dice in [n, ^n, ^n, ^n, ^n] }
  }

  SCORE = {
    "ones" => ->(dice) { dice.count(1) },
    "twos" => ->(dice) { dice.count(2) * 2 },
    "threes" => ->(dice) { dice.count(3) * 3 },
    "fours" => ->(dice) { dice.count(4) * 4 },
    "fives" => ->(dice) { dice.count(5) * 5 },
    "sixes" => ->(dice) { dice.count(6) * 6 },
    "full house" => ->(dice) { dice.sum },
    "four of a kind" => ->(dice) { 4 * dice.sort[1] },  # [n, n, n, n, _] or [_, n, n, n, n] when sorted; either way [1] is n
    "little straight" => ->(_) { 30 },
    "big straight" => ->(_) { 30 },
    "choice" => ->(dice) { dice.sum },
    "yacht" => ->(_) { 50 }
  }

  attr_reader :score

  def initialize(dice, category)
    @score = MATCH[category][dice] ? SCORE[category][dice] : 0
  end
end
