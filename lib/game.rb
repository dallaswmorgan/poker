require_relative 'hand.rb'
require_relative 'card.rb'
require_relative 'hand_rankings.rb'
require_relative 'deck.rb'
require_relative 'player.rb'


class Game

  def initlialize
    @player_1 = Player.new('Dallas', self)
    @player_2 = Player.new('Bentley', self)
    @deck = Deck.new.shuffle!
    @pot = 0
    @turn = @player_1
  end

  def


end
