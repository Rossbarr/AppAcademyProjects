require_relative "piece"

class Board
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @board.each_with_index do |row, i|
      row.index do |j|
        case i
        when 0
          row[j] = Piece.new
        when 1
          row[j] = Piece.new
        when 6
          row[j] = Piece.new
        when 7
          row[j] = Piece.new
        else
          row[j] = NullPiece.new
        end
      end
    end
  end

  def move_piece(start_pos, end_pos)
    not_possible = false
    raise ArgumentError when @board[start_pos].class == NullPiece
    raise StandardError when not_possible
  end

  def [](pos)
    x, y = pos[0], pos[1]
    return @board[x][y]
end
