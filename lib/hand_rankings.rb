require_relative 'deck.rb'

module HandRankings

  def is_pair?
    Deck::VALUES.each do |val, _|
      return true if cards.count { |card| card.value == val } == 2
    end
    false
  end

  def is_two_pair?
    first_pair = nil
    Deck::VALUES.each do |val, _|
      if cards.count { |card| card.value == val } == 2 && first_pair.nil?
        first_pair = val
      elsif cards.count { |card| card.value == val } == 2
        return true
      end
    end
    false
  end

  def is_three_of_a_kind?
    Deck::VALUES.each do |val, _|
      return true if cards.count { |card| card.value == val } == 3
    end
    false
  end

  def is_straight?
    cards.each_with_index do |card, idx|
      next if idx == cards.length - 1
      unless Deck::VALUES[cards[idx + 1].value] == Deck::VALUES[card.value] + 1
        return false
      end
    end
    true
  end

  def is_flush?
    suit = cards.first.suit
    cards.all? { |card| card.suit == suit }
  end

  def is_full_house?
    is_three_of_a_kind? && is_pair?
  end

  def is_four_of_a_kind?
    Deck::VALUES.each do |val, _|
      return true if cards.count { |card| card.value == val } == 4
    end
    false
  end

  def is_straight_flush?
    is_straight? && is_flush?
  end






  def straight_flush_kicker
    cards.sort.last
  end

  def four_of_a_kind_kicker
    Deck::VALUES.each do |val, _|
      return val if cards.count { |card| card.value == val } == 4
    end
  end

  def three_of_a_kind_kicker
    Deck::VALUES.each do |val, _|
      return val if cards.count { |card| card.value == val } == 3
    end
  end

  def full_house_kicker
    three_of_a_kind_kicker
  end

  def two_pair_kicker
    first_pair = nil
    second_pair = nil
    kicker = nil
    Deck::VALUES.each do |val, _|
      if cards.count { |card| card.value == val } == 2 && first_pair.nil?
        first_pair = val
      elsif cards.count { |card| card.value == val } == 2
        second_pair = val
      elsif cards.count { |card| card.value == val } == 1
        kicker = val
      end
    end
    if first_pair > second_pair
      [first_pair, second_pair, kicker]
    else
      [second_pair, first_pair, kicker]
    end
  end

  def pair_kicker
    pair = nil
    kicker = []
    Deck::VALUES.each do |val, _|
      if cards.count { |card| card.value == val } == 2
        pair = [val]
      elsif cards.count { |card| card.value == val } == 1
        kicker << val
      end
    end
    kicker.sort!.reverse!
    pair + kicker
  end

  def high_card_kicker
    kicker = []
    Deck::VALUES.each do |val, _|
      if cards.count { |card| card.value == val } == 1
        kicker << val
      end
    end
    kicker.sort!.reverse!
  end
end
