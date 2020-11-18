require_relative 'board.rb'

class Game
  def initialize(filename)
    board = Board.from_file(filename)
    @board = Board.new(board)
    system("clear")
    self.play
  end

  def play
    while !@board.solved?
      @board.render
      pos, move = self.prompt
      @board.move(pos, move.to_i)
      sleep(2)
    end
  end

  def prompt
    puts "Enter the number and position for your insert in the form of 'num row col'"
    move, x, y = gets.chomp.split(" ")
    pos = [x.to_i - 1, y.to_i - 1]
    return pos, move
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new("./puzzles/sudoku1.txt")
end
