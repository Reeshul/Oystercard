require 'oystercard'

describe Oystercard do

  subject(:oystercard) { Oystercard.new }

  it 'allows money to be topped up' do
    expect(oystercard.balance).to eq 0 
  end
    
end
