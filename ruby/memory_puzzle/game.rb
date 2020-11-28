require_relative 'board.rb'
require_relative 'human_player.rb'
require_relative 'computer_player.rb'

class Game
  def initialize(n=4, human = true)
    @board = Board.new(n)
    if human
      @player = HumanPlayer.new(n)
    else
      @player = ComputerPlayer.new(n)
    end
  end

  def play
    while !@board.won?
      @board.render
      
      guess1 = @player.prompt(nil)
      card1 = @board.reveal(guess1)
      @player.receive_revealed_card(guess1, card1)
      @board.render

      guess2 = @player.prompt(guess1)
      card2 = @board.reveal(guess2)
      @player.receive_revealed_card(guess2, card2)
      @board.render

      if card1 == card2
        @player.receive_match(guess1, guess2)
        puts "You got a match!"
      else
        card1.hide
        card2.hide
      end
    end
  end
end
