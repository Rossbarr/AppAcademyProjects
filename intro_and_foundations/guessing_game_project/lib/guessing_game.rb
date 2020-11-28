class GuessingGame
    def initialize(low, high)
        @secret_num = rand(low..high)
        @num_attempts = 0
        @game_over = false
    end

    def game_over?
        @game_over
    end

    def num_attempts
        @num_attempts
    end

    def check_num(num)
        @num_attempts += 1
        if num == @secret_num
            puts "you win"
            @game_over = true
        elsif num <= @secret_num
            puts "#{num} is too small, try again."
        elsif num >= @secret_num
            puts "#{num} is too big, try again."
        end
    end

    def ask_user
        puts "enter a number:"
        self.check_num(gets.chomp.to_i)
    end
end
