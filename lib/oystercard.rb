class Oystercard

  attr_reader :balance, :entry_station 

  LIMIT = 90
  MIN_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def topup(amount)
    @balance += amount
    raise "Balance can't be more than #{LIMIT}" if max_balance?
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < MIN_BALANCE
    @entry_station = station
    in_journey?
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
    in_journey?
  end

  def in_journey?
    !!entry_station
  end

  private

  def max_balance?
    @balance > LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

end
