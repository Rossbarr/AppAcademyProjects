class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next 
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Node.new(:head)
    @tail = Node.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail and @tail.prev == @head
  end

  def get(key)
    self.each do |curr_node|
      if curr_node.key == key
        return curr_node.val
      end
    end
  end

  def include?(key)
    self.each do |curr_node|
      if curr_node.key == key
        return true
      end
    end
    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    last.next = new_node
    new_node.prev = last
    new_node.next = @tail
    @tail.prev = new_node
    return new_node
  end

  def update(key, val)
    self.each do |curr_node|
      if curr_node.key == key
        curr_node.val = val
        return true
      end
    end
  end

  def remove(key)
    self.each do |curr_node|
      if curr_node.key == key
        curr_node.remove
        return true
      end
    end
  end

  def each
    curr_node = first
    while curr_node != @tail
      yield curr_node
      curr_node = curr_node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
