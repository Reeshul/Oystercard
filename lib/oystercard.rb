class Oystercard

  attr_reader :balance

  LIMIT = 90

  def initialize
    @balance = 0
  end
  def topup(amount)
    @balance += amount
    raise "Balance can't be more than #{LIMIT}" if max_balance?
  end

  private 

  def max_balance?
    @balance > LIMIT
  end

end