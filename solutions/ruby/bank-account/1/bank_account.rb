class BankAccount
  def open
    raise ArgumentError if status == :open

    self.status = :open
  end

  def close
    raise ArgumentError if status == :closed

    self.initialize
  end

  def balance
    raise ArgumentError if status == :closed

    @balance
  end

  def deposit(amount)
    raise ArgumentError unless amount > 0

    self.balance += amount
  end

  def withdraw(amount)
    raise ArgumentError unless amount > 0
    raise ArgumentError unless amount <= balance

    self.balance -= amount
  end

  private

  attr_writer :balance
  attr_accessor :status

  def initialize()
    self.balance  = 0
    self.status = :closed
  end
end