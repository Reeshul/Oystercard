require 'oystercard'

describe Oystercard do

  subject(:oystercard) { Oystercard.new }
  let(:station){ double :station}

  it 'displays balance' do
    expect(oystercard.balance).to eq 0
  end

  it 'tops up oystercard'do
  expect(oystercard).to respond_to(:topup).with(1).argument
  end

  it 'can top up the balance' do
    expect{ oystercard.topup(1) }.to change{oystercard.balance}.by 1
  end

  it 'balance can not be more than 90' do
    oystercard.topup(Oystercard::LIMIT)
    expect { oystercard.topup(1) }.to raise_error("Balance can't be more than #{Oystercard::LIMIT}")
  end

  it 'deducts money from oystercard' do
    expect{oystercard.send(:deduct, 1)}.to change{oystercard.balance}.by -1
  end

  it 'tells us whether we\'re in a journey' do
    expect(oystercard).to respond_to(:journey_status)
  end

  it 'status return false if oystercard is initially not in a journey' do
    expect(oystercard.journey_status).to be false
  end

  it 'status return true if oystercard with sufficient balance is in a journey' do
    oystercard.topup(Oystercard::MIN_BALANCE)
    oystercard.touch_in(station)
    expect(oystercard.journey_status).to be true
  end

  it 'status return false if oystercard with sufficient balance is no longer in a journey' do
    oystercard.topup(Oystercard::MIN_BALANCE)
    oystercard.touch_in(station)
    oystercard.touch_out
    expect(oystercard.journey_status).to be false
  end

  it 'tells us whether we\'ve touched in' do
    expect(oystercard).to respond_to(:touch_in)
  end

  it 'status return true if oystercard has touched in and has sufficient balance' do
    oystercard.topup(Oystercard::MIN_BALANCE)
    expect(oystercard.touch_in(station)).to be true
  end

  it 'status will return false when oystercard has touched out' do
    expect(oystercard.touch_out).to be false
  end

  it 'returns an error if an oystercard has insufficient balance for a fare' do
    oystercard.balance <= 1
    expect { oystercard.touch_in(station) }. to raise_error("Insufficient balance")
  end

  it 'will reduce the balance on the oystercard when we touch out' do
    oystercard.topup(Oystercard::MIN_BALANCE)
    oystercard.touch_in(station)
    expect { oystercard.touch_out }.to change{oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
  end

  it 'remembers the station where we touched in' do
    oystercard.topup(Oystercard::MIN_BALANCE)
    oystercard.touch_in(station)
    expect(oystercard.entry_station).to eq station
  end

end
