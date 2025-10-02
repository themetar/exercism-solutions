module Change
  
  def self.generate(coins, amount)
    raise NegativeTargetError if amount < 0

    coins_needed = Array.new(amount + 1, nil)

    coins_needed[0] = 0

    (1..amount).each do |target|
      m = coins.reject { |coin| coin > target }
                .map { |coin| coins_needed[target - coin] }
                .compact
                .min

      coins_needed[target] = m && m + 1
    end

    raise ImpossibleCombinationError if coins_needed[amount].nil?

    path = []

    while coins_needed[amount] > 0
      path << coins.find { |coin| coins_needed[amount - coin] == coins_needed[amount] - 1 }
      amount -= path.last
    end

    path
  end

  class ImpossibleCombinationError < StandardError
    
  end

  class NegativeTargetError < StandardError
    
  end

end