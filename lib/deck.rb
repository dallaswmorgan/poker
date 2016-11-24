require_relative 'card.rb'

class Deck
  attr_reader :cards
  VALUES = { two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7,
    eight: 8, nine: 9, ten: 10, jack: 11, queen: 12, king: 13, ace: 14 }
  SUITS = { diamonds: true, clubs: true, hearts: true, spades: true }

  def initialize
    @cards = []
    VALUES.each do |val, _|
      SUITS.each do |suit, _|
        @cards << Card.new(val, suit)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end

  def deal_hand!
    hand_cards = []
    5.times { hand_cards << cards.pop }
    hand_cards
  end

  def deal_replacement_cards!(num)
    raise "Cannot deal more than 3 cards" if num > 3
    replacement_cards = []
    num.times { replacement_cards << cards.pop }
    replacement_cards
  end
end
