require_relative "board.rb"
require_relative "human_player.rb"
require_relative "computer_player.rb"

class Game
    attr_reader(:players,:board,:current_player)
    
    def initialize(board_size = 3, hash = {x: false, o: true})
        @board = Board.new(board_size)

        @players = []
        hash.each do |k, v|
            if v
                @players << ComputerPlayer.new(k)
            else
                @players << HumanPlayer.new(k)
            end
        end
        @current_player = @players[0]
    end

    def switch_turn
        @players.rotate!
        @current_player = @players[0]
    end

    def play
        while @board.empty_positions?
            @board.print
            pos = @current_player.get_position(board.legal_positions)
            puts ""
            
            if !@board.place_mark(pos, @current_player.mark)
                puts "try again"
                self.play
            end

            if @board.win?(@current_player.mark)
                puts "You win!"
                return
            else
                self.switch_turn
            end


        end
        puts "Draw!"
        return
    end
end