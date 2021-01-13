require 'journey'

describe Journey do

  subject(:journey) { Journey.new("Stanmore") }

  it 'should return entry station if entry_station is called' do
    expect(journey.entry_station).to eq "Stanmore"
  end

  it 'should return nil if exit_station is called when not in journey' do
    expect(journey.exit_station).to eq nil
  end

  it 'should return exit station if exit_station is called' do
    journey.exit_station = "Baker Street"
    expect(journey.exit_station).to eq "Baker Street"
  end

  it 'PENALTY_FARE should be deducted from balance if touched out wihtout touching in first' do
    penalty_journey = Journey.new("PENALTY_FARE")
    expect(penalty_journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'PENALTY_FARE should be deducted from balance if card touched in but not touched out' do
    journey.exit_station = "PENALTY_FARE"
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'normal trip charges a minimum fare' do
    journey.exit_station = "Baker Street"
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end
  
end