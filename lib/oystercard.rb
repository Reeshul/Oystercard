class Oystercard

  attr_reader :balance, :entry_station, :list_of_journeys, :exit_station

  LIMIT = 90
  MIN_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @list_of_journeys = []
  end

  def topup(amount)
    @balance += amount
    raise "Balance can't be more than #{LIMIT}" if max_balance?
  end

  def touch_in(entry_station)
    @exit_station = nil
    raise "Insufficient balance" if @balance < MIN_BALANCE
    @entry_station = entry_station
    in_journey?
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    @list_of_journeys << { :entry_station => @entry_station, 
                            :exit_station => @exit_station }
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
