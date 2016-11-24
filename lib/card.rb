require_relative 'deck.rb'
class Card
  attr_reader :value, :suit

  def initialize(value, suit)
    @value = value
    @suit = suit
  end

  def to_s
    "The #{value} of #{suit}"
  end

  def ==(other_card)
    value == other_card.value && suit == other_card.suit
  end

  def <=>(other_card)
    Deck::VALUES[value] - Deck::VALUES[other_card.value]
  end
end
