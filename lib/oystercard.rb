class Oystercard

  attr_reader :balance, :entry_station, :journey_status

  LIMIT = 90
  MIN_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_status = false
    @entry_station = nil
  end

  def topup(amount)
    @balance += amount
    raise "Balance can't be more than #{LIMIT}" if max_balance?
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < MIN_BALANCE
    @entry_station = station
    @journey_status = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
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
