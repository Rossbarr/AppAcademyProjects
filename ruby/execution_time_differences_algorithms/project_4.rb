def windowed_max_range(array, window_size)
  current_max_range = 0
  i = 0
  while i + window_size <= array.length
    difference = array[i...i+window_size].max - array[i..i+window_size].min
    if difference > current_max_range
      current_max_range = difference
    end
    i += 1
  end
  return current_max_range
end

puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

class MinMaxStack
  attr_reader(:max, :min)

  def initialize
    @stack = []
    @max = nil
    @min = nil
  end

  def push(item)
    @stack.push(item)

    if @max == nil
      @max = item
    elsif item >= @max
      @max = item
    end

    if @min == nil
      @min = item
    elsif item <= @min
      @min = item
    end
  end

  def pop
    @stack.pop
  end

  def peek
    @stack.last()
  end

  def size
    @stack.length
  end

  def empty?
    @stack.first == nil
  end
end

class StackQueue
  def initialize
    @stack1 = MyStack.new()
    @stack2 = Mystack.new()
    @topstack = @stack1
  end

  def enqueue(item)
    @topstack.push(item)
    if @topstack == @stack1
      @topstack = @stack2
    else
      @topstack = @stack1
    end
    dequeue
  end

  def dequeue
    @topstack.pop(item)
  end

  def size
    return @stack1 + @stack2
  end

  def empty?
    return @stack1 + @stack2 == 0
  end
end
