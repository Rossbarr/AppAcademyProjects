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
  end

  def push(item)
    @stack.push({
      max: new_max(item),
      min: new_min(item),
      value: item
    })
  end

  def pop
    @stack.pop[:value] unless empty?
  end

  def peek
    @stack.last[:value] unless empty?
  end

  def size
    @stack.length
  end

  def empty?
    @stack.empty?
  end

  def max
    @stack.last[:max] unless empty?
  end

  def min
    @stack.last[:min] unless empty?
  end

  private

  def new_max(item)
    if empty?
      return item
    else
      return [max, item].max
    end
  end

  def new_min(item)
    if empty?
      return item
    else
      return [min, item].min
    end
  end
end

class MinMaxStackQueue
  def initialize
    @instack = MinMaxStack.new()
    @outstack = MinMaxStack.new()
  end

  def enqueue(item)
    @instack.push(item)
  end

  def dequeue
    queueify if @outstack.empty?
    @outstack.pop()
  end

  def size
    return @instack.size + @outstack.size
  end

  def empty?
    return @instack.empty? && @outstack.empty?
  end

  def max
    maxes = []
    maxes << @instack.max unless @instack.empty?
    maxes << @outstack.max unless @outstack.empty?
    return maxes.max
  end

  def min
    mins = []
    mins << @instack.min unless @instack.empty?
    mins << @outstack.min unless @outstack.empty?
    return mins.min
  end

  private

  def queueify
    @outstack.push(@instack.pop) until @instack.empty?
  end
end

def max_windowed_range(array, window_size)
  queue = MinMaxStackQueue.new
  best_range = nil

  array.each_with_index do |el, i|
    queue.enqueue(el)
    queue.dequeue if queue.size > window_size

    if queue.size == window_size
      current_range = queue.max - queue.min
      best_range = current_range if !best_range || current_range > best_range
    end
  end

  best_range
end

p max_windowed_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p max_windowed_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p max_windowed_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p max_windowed_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
