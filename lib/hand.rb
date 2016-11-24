require_relative 'hand_rankings.rb'

class Hand
  include HandRankings
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def discard_cards!(indices)
    raise "Cannot discard more than 3 cards" if indices.length > 3
    raise "Invalid card index given" if indices.any? { |i| i < 0 || i >= 4 }
    @cards.delete_if.with_index { |_, i| indices.include?(i) }
  end

  def take_cards!(cards)
    @cards += cards
  end

  def calc_strength
    return 8 if is_straight_flush?
    return 7 if is_four_of_a_kind?
    return 6 if is_full_house?
    return 5 if is_flush?
    return 4 if is_straight?
    return 3 if is_three_of_a_kind?
    return 2 if is_two_pair?
    return 1 if is_pair?
    0
  end

  def <=>(other_hand)
    return 1 if calc_strength > other_hand.calc_strength
    return -1 if calc_strength < other_hand.calc_strength
    if is_straight_flush? || is_straight? || is_flush?
      return 1 if straight_flush_kicker > other_hand.straight_flush_kicker
      return -1 if straight_flush_kicker < other_hand.straight_flush_kicker
    elsif is_four_of_a_kind?
      return 1 if four_of_a_kind_kicker > other_hand.four_of_a_kind_kicker
      return -1 if four_of_a_kind_kicker < other_hand.four_of_a_kind_kicker
    elsif is_three_of_a_kind? || is_full_house?
      return 1 if three_of_a_kind_kicker > other_hand.three_of_a_kind_kicker
      return -1 if three_of_a_kind_kicker < other_hand.three_of_a_kind_kicker
    elsif is_two_pair?
      two_pair_kicker.each_index do |i|
        return 1 if two_pair_kicker[i] > other_hand.two_pair_kicker[i]
        return -1 if two_pair_kicker[i] < other_hand.two_pair_kicker[i]
      end
    elsif is_pair?
      pair_kicker.each_index do |i|
        return 1 if pair_kicker[i] > other_hand.pair_kicker[i]
        return -1 if pair_kicker[i] < other_hand.pair_kicker[i]
      end
    else
      high_card_kicker.each_index do |i|
        return 1 if high_card_kicker[i] > other_hand.high_card_kicker[i]
        return -1 if high_card_kicker[i] < other_hand.high_card_kicker[i]
      end
    end
    0
  end
end
