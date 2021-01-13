require_relative 'Journey'

class Oystercard

  attr_reader :balance, :list_of_journeys, :current_journey

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(balance = 0)
    @balance = balance
    @list_of_journeys = []
    @current_journey = nil
  end

  def topup(amount)
    @balance += amount
    raise "Balance can't be more than #{MAX_BALANCE}" if max_balance?
  end

  def touch_in(entry_station)
    no_touch_in_penalty if in_journey?
    raise "Insufficient balance" if @balance < MIN_BALANCE
    @current_journey = Journey.new(entry_station)
    in_journey?
  end

  def touch_out(exit_station)
    no_touch_out_penalty unless in_journey?
    @current_journey.exit_station = exit_station
    @list_of_journeys << @current_journey
    deduct(@current_journey.fare)
    @current_journey = nil
    in_journey?
  end

  def in_journey?
    @current_journey == nil ? false : true
  end

  private

  def max_balance?
    @balance > MAX_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end

  def no_touch_in_penalty
    @current_journey.exit_station = "PENALTY_FARE"
    @current_journey = nil
  end

  def no_touch_out_penalty
    @current_journey = Journey.new("PENALTY_FARE")
  end

end
