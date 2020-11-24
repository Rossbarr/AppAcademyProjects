require_relative "00_tree_node.rb"

class KnightPathFinder
  def self.valid_moves(pos)
    x, y = pos
    possible_moves = [[x+2, y+1], [x+2, y-1], [x+1, y-2], [x-1, y-2], [x-2, y-1], [x-2, y+1], [x-1, y+2], [x+1, y+2]]
    valid_moves = possible_moves.select do |move|
      i, j = move
      if i.between?(0, 7) and j.between?(0, 7)
        true
      else
        false
      end
    end
    return valid_moves
  end

  attr_reader(:root_node, :considered_positions)

  def initialize(pos = [0, 0])
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
    self.build_move_tree
  end

  def build_move_tree
    queue = [@root_node]
    while queue.length > 0
      node = queue.shift
      new_moves = new_move_positions(node.value)
      new_moves.each do |pos|
        new_node = PolyTreeNode.new(pos)
        node.add_child(new_node)
        queue.push(new_node)
      end
    end
  end

  def find_path(end_pos)
    trace_back_path(@root_node.bfs(end_pos))
  end

  private

  def trace_back_path(end_node)
    path = []
    current_node = end_node
    while true
      path.push(current_node.value)
      parent_node = current_node.parent
      if parent_node != nil
        current_node = parent_node
      else
        return path.reverse
      end
    end
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_moves = valid_moves.select do |move|
      if @considered_positions.include?(move)
        false
      else
        true
      end
    end
    new_moves.each do |move|
      @considered_positions.push(move)
    end
    new_moves
  end
end
