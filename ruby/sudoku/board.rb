require_relative 'tile.rb'

class Board
  def self.from_file(file)
    grid = []
    
    File.open(file).each_line { |s|
      line = s.chomp.split("")
      arr = []
      line.each do |num|
        if num.to_i == 0
          arr << Tile.new(0, false)
        else
          arr << Tile.new(num.to_i, true)
        end
      end
      grid << arr
    }
    return grid
  end

  def initialize(grid)
    @grid = grid
    system("clear")
  end

  def render
    system("clear")
    @grid.each_with_index do |line, i|
      if i == 3 or i == 6
        print("------+-------+------\n")
      end
      line.each_with_index do |tile, j|
        if j == 3 or j == 6
          print("| ")
        end
        print(tile.value.to_s + " ")
      end
      print("\n")
    end
    return true
  end

  def solved?
    @grid.each do |line|
      if line.any? { |ele| ele.value == 0 }
        return false
      end
    end
    return true
  end

  def move(pos, move)
    if valid_move?(pos, move)
      x, y = pos
      @grid[x][y].value = move
    end
    return true
  end

  def valid_move?(pos, move)
    x, y = pos
    if @grid[x][y].given
      return false
    end

    return (check_lines(pos, move) && check_square(pos, move))
  end

  def check_lines(pos, move)
    x, y = pos

    @grid[x].each do |ele|
      if ele.value == move
        puts "The same value is in that row."
        return false
      end
    end

    @grid.each do |row|
      if row[y].value == move
        puts "The same value is in that column."
        return false
      end
    end

    return true
  end

  def check_square(pos, move)
    x, y = pos
    column = 0
    row = 0

    if 0 <= x && x < 3
      column = 0
    elsif 3 <= x && x < 6
      column = 1
    elsif 6 <= x && x < 9
      column = 2
    end

    if 0 <= y && y < 3
      row = 0
    elsif 3 <= y && y < 6
      row = 1
    elsif 6 <= y && y < 9
      row = 2
    end
 
    (0..2).each do |i|
      (0..2).each do |j|
        m = (x + i) % 3 + column * 3
        n = (y + j) % 3 + row * 3
        if @grid[m][n].value == move
          puts "#{@grid[m][n].value} at board position #{m + 1}, #{n + 1} conflicts."
          return false
        end
      end
    end
    return true
  end
end
