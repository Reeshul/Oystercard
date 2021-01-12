class Oystercard

  attr_reader :balance

  LIMIT = 90
  MIN_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_status = false
  end
  def topup(amount)
    @balance += amount
    raise "Balance can't be more than #{LIMIT}" if max_balance?
  end

  def in_journey?
    @journey_status
  end

  def touch_in
    raise "Insufficient balance" if @balance < MIN_BALANCE
    @journey_status = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @journey_status = false
  end

  private

  def max_balance?
    @balance > LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
