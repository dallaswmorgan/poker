require 'rspec'
require 'deck'
require 'byebug'

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'creates a deck of 52 unique cards' do
      expect(deck.cards.length).to eq(52)
      expect(deck.cards.uniq.length).to eq(52)
    end
  end

  describe '#shuffle!' do
    it 'modifies the original array of cards' do
      original = deck.cards.dup
      deck.shuffle!
      expect(deck.cards).not_to eq(original)
    end

    it 'contains the same cards in a different order' do
      original = deck.cards.dup
      deck.shuffle!
      deck.cards.each do |card|
        expect(original).to include(card)
      end
    end
  end

  describe '#deal_hand!' do
    it 'creates an array of 5 cards' do
      expect(deck.deal_hand!.length).to eq(5)
    end

    it 'removes 5 cards from the deck' do
      hand_cards = deck.deal_hand!
      # debugger
      deck.cards.each do |card|
        expect(hand_cards).not_to include(card)
      end

      hand_cards.each do |card|
        expect(deck.cards).not_to include(card)
      end
    end
  end

  describe '#deal_replacement_cards' do
    it 'creates an array of cards of specified length' do
      expect(deck.deal_replacement_cards!(2).length).to eq(2)
    end

    it 'raises an error if asked to distribute more than 3 cards' do
      expect { deck.deal_replacement_cards!(4) }.to raise_error("Cannot deal more than 3 cards")
    end
  end
end
