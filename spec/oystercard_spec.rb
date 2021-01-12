require 'oystercard'

describe Oystercard do

  subject(:oystercard) { Oystercard.new }

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
    expect{oystercard.deduct(1)}.to change{oystercard.balance}.by -1
  end
  
  it 'tells us whether we\'re in a journey' do
    expect(oystercard).to respond_to(:in_journey?)
  end

  it 'status return false if oystercard is initially not in a journey' do
    expect(oystercard).not_to be_in_journey 
  end

  it 'status return true if oystercard is in a journey' do
    oystercard.touch_in
    expect(oystercard.in_journey?).to be true 
  end

  it 'status return false if oystercard is no longer in a journey' do
    oystercard.touch_in
    oystercard.touch_out
    expect(oystercard.in_journey?).to be false 
  end

  it 'tells us whether we\'ve touched in' do
    expect(oystercard).to respond_to(:touch_in)
  end

  it 'status return true if oystercard has touched in' do
    expect(oystercard.touch_in).to be true 
  end

  it 'status will return false when oystercard has touched out' do
    expect(oystercard.touch_out).to be false
  end

end