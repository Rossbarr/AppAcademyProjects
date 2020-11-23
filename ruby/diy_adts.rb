class Stack
  def initialize
    @stack = []
  end

  def push(ele)
    @stack.push(ele) if !@stack.include?(ele)
  end

  def pop
    @stack.pop
  end

  def peek
    @stack[-1]
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(ele)
    @queue.push(ele) if !@queue.include?(ele)
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue[0]
  end
end

class Map
  def initialize
    @map = []
  end

  def set(key, value)
    @map.each { |ele| return false if ele[0] == key }
    @map.push([key, value])
  end

  def get(key)
    @map.each { |ele| return ele[1] if ele[0] == key }
  end

  def delete(key)
    @map.each { |ele| @map.delete(ele) if ele[0] == key }
  end

  def show
    p @map
  end
end
