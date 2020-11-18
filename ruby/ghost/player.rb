class Player
    attr_reader(:name, :count)

    def initialize(name, count = 0)
        @name = name
        @count = count
    end
    
    def guess
        puts "#{@name}, enter a letter for the word-fragment : "
        return gets.chomp
    end

    def alert_invalid_guess
        puts "invalid guess entered. Please, try again."
    end

    def plus_one
        @count += 1
    end
end