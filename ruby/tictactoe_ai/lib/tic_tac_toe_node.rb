require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader(:board, :next_mover_mark, :prev_move_pos, :children)

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    @children ||= self.children

    if @board.over?
      if @board.winner == evaluator or @board.tied?
        return false
      else
        return true
      end
    end

    if evaluator == @next_mover_mark and @children.all? { |child| child.losing_node?(evaluator) }
      return true
    elsif evaluator != @next_mover_mark and @children.any? { |child| child.losing_node?(evaluator) }
      return true
    end

    false
  end

  def winning_node?(evaluator)
    @children ||= self.children

    if @board.over?
      if @board.winner == evaluator
        return true
      else
        return false
      end
    end

    if evaluator == @next_mover_mark and @children.any? { |child| child.winning_node?(evaluator) }
      return true
    elsif evaluator != @next_mover_mark and @children.all? { |child| child.winning_node?(evaluator) }
      return true
    end
    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    if @next_mover_mark == :x
      next_next_mark = :o
    else
      next_next_mark = :x
    end

    next_mover_mark = @next_mover_mark

    children = []
    (0..2).each do |x|
      (0..2).each do |y|
        pos = [x, y]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = next_mover_mark
          new_node = TicTacToeNode.new(new_board, next_next_mark, [x, y])
          children.push(new_node)
        end
      end
    end
    return children
  end

  def inspect
    "#{@board}"
  end
end
