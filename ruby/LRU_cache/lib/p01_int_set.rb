class MaxIntSet
  attr_reader :store, :max

  def initialize(max)
    raise ArgumentError.new("max must be an integer") unless max.is_a?(Integer)
    raise ArgumentError.new("max must be greater than 0") if max <= 0
    
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
    return true
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    @store[num] if is_valid?(num)
  end

  private

  def is_valid?(num)
    raise ArgumentError.new("Out of bounds") if num >= @max or num < 0
    num.is_a?(Integer)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if not self[num].include?(num)
      self[num] << num
      return true
    end
    return false
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      return true
    end
    return false
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end

    unless self[num].include?(num)
      self[num] << num
      @count += 1
      return true
    end
    return false
  end

  def remove(num)
    if self[num].include?(num)
      self[num].delete(num)
      @count -= 1
      return true
    end
    return false
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr|
      arr.each do |num|
        new_store[num % (num_buckets * 2)] << num
      end
    end
    @store = new_store
  end
end
