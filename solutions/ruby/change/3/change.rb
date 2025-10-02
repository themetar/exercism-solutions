module Change
  
  # A dynamic programming algorithm. It works by building up an array of smallest number of coins
  # needed to make a certain change (the array's index). The number of coins for change X is the
  # coins for change of "X - a_certain_coin" plus 1 (for the added coin).
  # Then you can trace back your steps too see which coin should be picked at the optimal sub-amounts.

  def self.generate(coins, amount)
    raise NegativeTargetError if amount < 0

    coins_count = number_of_coins_per_amount(coins, amount)

    raise ImpossibleCombinationError if coins_count[amount].nil?

    backtrack_change(coins, coins_count, amount)
  end

  class << self
    private

    # Builds the array of coin counts
    #
    def number_of_coins_per_amount(coins, amount)
      Array.new(amount + 1, nil).tap do |coins_count|
        coins_count[0] = 0

        (1..amount).each do |target|
          least_coins = coins.reject { |coin| coin > target }
                          .map { |coin| coins_count[target - coin] }
                          .compact
                          .min

          coins_count[target] = least_coins && least_coins + 1
        end
      end
    end

    # Gets the list of coin denominations from array of counts
    #
    def backtrack_change(coins, coins_count, amount)
      [].tap do |change|
        while coins_count[amount] > 0
          change << coins.find { |coin| coins_count[amount - coin] == coins_count[amount] - 1 }
          amount -= change.last
        end
      end
    end
  end

  class ImpossibleCombinationError < StandardError
  end

  class NegativeTargetError < StandardError
  end

end
