class Journey

  attr_reader :entry_station
  attr_accessor :exit_station

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def fare
    ( @entry_station == "PENALTY_FARE" || @exit_station == "PENALTY_FARE" ) ? PENALTY_FARE : MINIMUM_FARE
  end
end