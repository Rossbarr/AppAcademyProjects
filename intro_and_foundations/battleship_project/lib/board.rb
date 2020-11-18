class Board
    def self.print_grid(grid)
        grid.each { |line| puts line.join(" ") }
    end

    attr_reader(:size)
    
    def initialize(n)
        @grid = Array.new(n) { Array.new(n, :N) }
        @size = n*n
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos, value)
        @grid[pos[0]][pos[1]] = value
    end

    def num_ships
        @grid.flatten.count(:s)
    end

    def attack(pos)
        if self.[](pos) == :S
            self.[]=(pos, :H)
            puts "you sunk my battleship!\n"
            true
        else
            self.[]=(pos, :X)
            false
        end
    end

    def place_random_ships
        while self.num_ships < @size/4
            self.[]=([rand(@grid.length-1), rand(@grid.length-1)], :S)
        end
    end

    def hidden_ships_grid
        @grid.map do |arr|
            arr.map do |ele|
                if ele == :S
                    :N
                else
                    ele
                end
            end
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(self.hidden_ships_grid)
    end
end
