module SavingsAccount
  def self.interest_rate(balance)
    case balance
    when (0...1000) then    0.5
    when (1000...5000) then 1.621
    when (5000...) then     2.475
    else                    3.213
    end
  end

  def self.annual_balance_update(balance)
    balance + balance * self.interest_rate(balance) / 100.0
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    years = 0
    balance = current_balance

    while balance < desired_balance
      years += 1
      balance = self.annual_balance_update(balance)
    end

    years
  end
end
