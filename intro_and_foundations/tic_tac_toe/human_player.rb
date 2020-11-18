class HumanPlayer
    attr_reader(:mark)

    def initialize(mark)
        @mark = mark
    end

    def get_position(legal_positions)
        puts "Enter a position in the form of 'row col', starting from 1, (e.g: '2 1' for 2nd row, 1st column)."
        pos = gets.chomp.split(" ").map { |e| (e.to_i - 1) }
        if pos.length != 2 or !legal_positions.include?(pos)
            puts pos
            puts "invalid position; please try again"
            self.get_position
        end
        return pos
    end
end