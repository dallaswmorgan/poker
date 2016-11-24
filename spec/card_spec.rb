require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:king, :hearts) }

  describe '#initialize' do
    it 'sets a value for the card' do
      expect(card.value).to eq(:king)
    end

    it 'sets a suit for the card' do
      expect(card.suit).to eq(:hearts)
    end
  end

  describe '#to_s' do
    it 'contains the value and suit of card' do
      expect(card.to_s).to include("king")
      expect(card.to_s).to include("hearts")
    end
  end
end
