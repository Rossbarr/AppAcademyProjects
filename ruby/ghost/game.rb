require_relative "player.rb"

class Game
    def initialize(players = nil)
        @players = []
        if players != nil
            players.each { |name| @players << Player.new(name) }
        else 
            @players = [Player.new("RED"), Player.new("BLU")]
        end

        @current_player = @players[0]

        @fragment = ""

        dict = Hash.new()
        File.foreach("dictionary.txt") { |word| dict[word.chomp] = word.chomp }
        @@dictionary = dict
    end

    def play_game
        over = false
        while !over
            self.play_round
            if @current_player.count == 5
                puts "#{@current_player.name} has 'GHOST'"
                puts "#{@current_player.name} loses!"
                @players.delete(@current_player)
                @current_player = @players[0]
                if @players.length == 1
                    over = true
                    puts "#{@current_player.name} wins!"
                end
            else
                puts "#{@current_player.name} has '#{"GHOST"[0...@current_player.count]}'"
            end
        end
    end

    def play_round
        puts "The current word-fragment is '#{@fragment}'"
        self.take_turn(@current_player)
        if @@dictionary.has_key?(@fragment)
            puts "#{@fragment} is a word!"
            puts "#{@current_player.name} gets a letter."
            @current_player.plus_one
            @fragment = ""
        else
            self.next_player!
            self.play_round
        end
    end

    def take_turn(player = @current_player)
        letter = player.guess
        if !valid_play?(letter)
            player.alert_invalid_guess
            self.take_turn(player)
        else
            @fragment += letter
            return true
        end
    end

    def next_player!
        @current_player = @players.rotate![0]
    end

    def valid_play?(str)
        alpha = ("a".."z").to_a
        return false if !alpha.include?(str) or str.length != 1

        @@dictionary.each_key do |word|
            return true if word.start_with?(@fragment + str)
        end

        return false
    end
end
