class PolyTreeNode
  attr_reader(:value, :parent, :children)

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    begin
      @parent.remove_child(self) if @parent != nil
    rescue
    end
    @parent = node if node != @parent
    @parent.add_child(self) if @parent != nil
  end

  def add_child(node)
    return false if node == nil
    @children.push(node) if !children.include?(node)
    node.parent=(self) unless node.parent == self
    return true
  end

  def remove_child(node)
    return false if node == nil
    raise "child not found" if !@children.include?(node)
    @children.delete(node)
    node.parent=(nil)
    return true
  end

  def dfs(target)
    return self if @value == target

    @children.each do |child|
      node = child.dfs(target)
      return node if node != nil
    end

    nil
  end

  def bfs(target)
    queue = [self]
    while queue.length > 0
      node = queue.shift
      node.children.each { |child| queue.push(child) }
      return node if node.value == target
    end
    nil
  end
end
