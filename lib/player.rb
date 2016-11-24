class Player
  attr_accessor :pot
  attr_reader :name
  def initlialize(name, game)
    @name = name
    @game = game
    @hand = nil
    @pot = 500
  end

  def receive_hand(hand)
    @hand = hand
  end

  def make_bet(amount)
    raise 'Cannot bet more money than you have!' unless amount <= pot
    @pot -= amount
    @game.pot += amount
  end

  def game_over?
    @pot == 0
  end

  def ask_for_discard
    discard = nil
    until discard
      puts "#{name}, what cards would you like to discard? You may discard up to 3 [card1, card2, card3]"
      discards = gets.chomp.split(',').map { |s| Integer(s) }
      if discards.length > 3
        puts "Can only discard up to 3 cards"
        discard = nil
      end
    end
    discard
  end

  def ask_for_bet
    bet = 0
    puts "#{name} would you like to fold, see, or raise?"
    input = gets.chomp

    if input == 'raise'
      puts 'how much would you like to raise by?'
      bet = gets.chomp.to_i
      if bet > @pot
        puts 'You cannot bet more than you have!'
        ask_for_bet
      end
      make_bet(bet)
    end

    bet
  end

end
