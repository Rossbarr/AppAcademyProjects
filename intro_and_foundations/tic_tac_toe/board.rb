class Board
    attr_reader(:board)

    def initialize(n = 3)
        @board = Array.new(n) { Array.new(n, "_") }
    end

    def valid?(pos)
        if 0 <= pos[0] and pos[0] < @board.length and 0 <= pos[1] and pos[1] < @board[0].length
            return true
        else
            puts "invalid board position"
            return false
        end
    end
    
    def empty?(pos)
        @board[pos[0]][pos[1]] == "_" if self.valid?(pos)
    end

    def empty_positions?
        @board.each do |row|
            return true if row.any? { |e| e == "_" }
        end
        return false
    end

    def legal_positions
        arr = []
        @board.each_with_index do |row, x|
            row.each_with_index do |ele, y| 
                if ele == "_"
                    arr << [x, y]
                end
            end
        end
        arr        
    end

    def place_mark(pos, mark)
        @board[pos[0]][pos[1]] = mark if self.valid?(pos) and self.empty?(pos)
    end

    def print
        @board.each do |row|
            p row
        end
    end

    def win_row?(mark)
        @board.each do |row|
            if row.all? { |ele| ele == mark }
                puts "It's a full row!"
                self.print
                return true
            end
        end
        return false
    end
    
    def win_col?(mark)
        @board.transpose.each do |col|
            if col.all? { |ele| ele == mark }
                puts "It's a full column!"
                self.print
                return true
            end
        end
        return false
    end

    def win_diag?(mark)
        arr = []
        (0...@board.length).each { |i| arr << @board[i][i] }
        if arr.all? { |e| e == mark }
            puts "It's a full diagonal!"
            self.print
            return true
        end
        
        arr = []
        (0...@board.length).each { |i| arr << @board[i][@board.length - 1 - i] }
        if arr.all? { |e| e == mark }
            puts "It's a full diagonal!"
            self.print
            return true
        end
    
        return false
    end

    def win?(mark)
        return (win_row?(mark) or win_col?(mark) or win_diag?(mark))
    end
end