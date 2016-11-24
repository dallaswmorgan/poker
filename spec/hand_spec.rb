require 'rspec'
require 'hand'


describe Hand do
  let(:card1) { double('card1') }
  let(:card2) { double('card2') }
  let(:card3) { double('card3') }
  let(:card4) { double('card4') }
  let(:card5) { double('card5') }
  let(:cards) { [card1, card2, card3, card4, card5] }
  subject(:hand) { Hand.new(cards) }
  describe '#initialize' do
    it 'accepts an array of 5 cards' do
      expect(hand.cards.length).to eq(5)
    end
  end

  describe '#discard_cards!' do
    it 'raises an error if given more than 3 card indices' do
      expect { hand.discard_cards!([0, 1, 2, 3]) }.to raise_error("Cannot discard more than 3 cards")
    end

    it 'raises an error if any index is invalid' do
      expect { hand.discard_cards!([-2, 1, 7]) }.to raise_error("Invalid card index given")
    end

    it 'removes cards at given indices from hand' do
      hand.discard_cards!([0, 2])
      expect(hand.cards).to eq([card2, card4, card5])
    end
  end

  describe '#take_cards!' do
    let(:new_cards) { [card1, card2, card3] }
    it 'accepts an array of enough cards to fill hand' do
      hand.discard_cards!([0, 2, 3])
      hand.take_cards!(new_cards)
      expect(hand.cards.length).to eq(5)
    end
  end

  describe '#<=>' do
    subject(:hand1) { [Card.new(:two, :diamonds), Card.new(:three, :clubs),
    Card.new(:four, :spades), Card.new(:five, :hearts), Card.new(:six, :clubs)] }
    let(:hand2) { [Card.new(:two, :hearts), Card.new(:three, :diamonds),
    Card.new(:four, :clubs), Card.new(:five, :diamonds), Card.new(:six, :spades)] }
    context 'two hands of the same strength' do
      it 'returns 0' do
        expect(hand1 <=> hand2).to eq(0)
      end
    end

    let(:hand3) { [Card.new(:two, :hearts), Card.new(:three, :diamonds),
    Card.new(:four, :clubs), Card.new(:five, :diamonds), Card.new(:seven, :spades)] }
    context 'first hand better than second hand' do
      it 'returns -1' do
        expect(hand1 <=> hand3).to eq(-1)
      end
    end
  end
end
