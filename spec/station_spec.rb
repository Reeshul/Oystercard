require 'station'

describe Station do

  subject(:station) { Station.new(name: "Stanmore", zone: 5) }

  it 'has a name' do
    expect(station.name).to eq "Stanmore"
  end

  it 'has a zone' do
    expect(station.zone).to eq 5
  end
end