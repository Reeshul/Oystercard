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

end