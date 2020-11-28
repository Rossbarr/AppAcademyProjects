require_relative "board"
require_relative "player"

class Battleship
    attr_reader(:player, :board)
    def initialize(n)
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = @board.size/2
    end

    def start_game
        @board.place_random_ships
        print("There are ", @board.num_ships, " ships left\n")
        @board.print
    end

    def lose?
        if @remaining_misses <= 0
            puts "you lose"
            return true
        end
        return false
    end
    
    def win?
        if @board.num_ships <= 0
            puts "you win"
            return true
        end
        return false
    end

    def game_over?
        win? or lose?
    end

    def turn
        guess = @player.get_move
        @remaining_misses -= 1 if !@board.attack(guess)
        @board.print
        print("remaining misses: ", @remaining_misses, "\n")
    end
end
