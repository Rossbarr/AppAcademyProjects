class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    unless i.between?(0, self.store.length - 1)
      raise "Overflow error"
    end
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i > @count - 1
    if i < 0 and i >= -@count
      @store[@count + i]
    elsif i >= 0
      @store[i]
    else
      return nil
    end
  end

  def []=(i, val)
    return nil if i > @count
    if i < 0 and i >= -@count
      @store[@count + i] = val
    elsif i >= 0
      @store[i] = val
    else
      return nil
    end
  end

  def capacity
    @store.length
  end

  def include?(val)
    self.each do |el|
      if val == el
        return true
      end
    end
    return false
  end

  def push(val)
    if @count >= capacity
      resize!
    end

    self[@count] = val
    @count += 1
  end

  def unshift(val)
    if @count >= capacity
      resize!
    end

    i = 0
    while 0 <= @count - i - 1
      self[@count - i] = self[@count - i - 1]
      i += 1
    end

    @store[0] = val
    @count += 1
  end

  def pop
    if @count > 0
      node = last
      @store[@count - 1] = nil
      @count -= 1
    else
      node = nil
    end
    return node
  end

  def shift
    val = self[0]
    
    i = 0
    while i < @count
      @store[i] = @store[i+1]
      i += 1
    end

    @count -= 1
    return val
  end

  def first
    @store[0]
  end

  def last
    @store[@count - 1]
  end

  def each
    i = 0
    while i <= @count - 1
      yield @store[i]
      i += 1
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    i = 0
    while i < @count - 1
      if other[i] != self[i]
        return false
      end
      i += 1
    end
    return true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_array = StaticArray.new(@store.length * 2)
    i = 0
    self.each do |el|
      new_array[i] = el
      i += 1
    end
    @store = new_array
  end
end
