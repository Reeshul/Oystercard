require 'oystercard'

describe Oystercard do

  subject(:oystercard) { Oystercard.new(1) }
  let(:entry_station){ double :station}
  let(:exit_station){ double :station}
  let(:journey) { Journey.new("Stanmore") }
  

  it 'displays balance' do
    expect(oystercard.balance).to eq 1
  end

  it 'tops up oystercard'do
  expect(oystercard).to respond_to(:topup).with(1).argument
  end

  it 'can top up the balance' do
    expect{ oystercard.topup(1) }.to change{oystercard.balance}.by 1
  end

  it 'balance can not be more than 90' do
    oystercard.topup(Oystercard::MAX_BALANCE - 1)
    expect { oystercard.topup(1) }.to raise_error("Balance can't be more than #{Oystercard::MAX_BALANCE}")
  end

  it 'deducts money from oystercard' do
    expect{oystercard.send(:deduct, 1)}.to change{oystercard.balance}.by -1
  end

  it 'tells us whether we\'re in a journey' do
    expect(oystercard).to respond_to(:in_journey?)
  end

  it 'status return false if oystercard is initially not in a journey' do
    expect(oystercard.in_journey?).to be false
  end

  it 'status return true if oystercard with sufficient balance is in a journey' do
    oystercard.touch_in(entry_station)
    expect(oystercard.in_journey?).to be true
  end

  it 'status return false if oystercard with sufficient balance is no longer in a journey' do
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.in_journey?).to be false
  end

  it 'tells us whether we\'ve touched in' do
    expect(oystercard).to respond_to(:touch_in)
  end

  it 'status return true if oystercard has touched in and has sufficient balance' do
    expect(oystercard.touch_in(entry_station)).to be true
  end

  it 'status will return false when oystercard has touched out' do
    oystercard.touch_in(entry_station)
    expect(oystercard.touch_out(exit_station)).to be false
  end

  it 'returns an error if an oystercard has insufficient balance for a fare' do
    card_with_zero_balance = Oystercard.new(0)
    expect { card_with_zero_balance.touch_in(entry_station) }. to raise_error("Insufficient balance")
  end

  it 'will reduce the balance on the oystercard when we touch out' do
    oystercard.touch_in(entry_station)
    expect { oystercard.touch_out(exit_station) }.to change{oystercard.balance}.by(-Journey::MINIMUM_FARE)
  end

  it 'remembers the station where we touched in' do
    oystercard.touch_in(entry_station)
    expect(oystercard.current_journey.entry_station).to eq entry_station
  end

  it 'remembers the station where we touched out' do
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.list_of_journeys[-1].exit_station).to eq exit_station
  end

  it 'shows us all my previous trips' do
    expect(oystercard).to respond_to(:list_of_journeys)
  end

  it 'card initially has an empty list of journeys' do
    expect(oystercard.list_of_journeys).to eq []
  end

  it 'card creates a journey after touching in and touching out' do
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.list_of_journeys[-1]).to be_a Journey
  end

end
