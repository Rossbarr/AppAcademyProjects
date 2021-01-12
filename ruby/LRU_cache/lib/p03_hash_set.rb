class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if @count >= num_buckets
      resize!
    end

    unless include?(key)
      num = key.hash % num_buckets
      self[num] << key
      @count += 1
      return true
    end

    return false
  end

  def include?(key)
    num = key.hash % num_buckets
    return self[num].include?(key)
  end

  def remove(key)
    if include?(key)
      num = key.hash % num_buckets
      self[num].delete(key)
      @count -= 1
      return true
    end

    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr|
      arr.each do |el|
        new_store[el.hash % (num_buckets * 2)] << el
      end
    end
    @store = new_store
  end
end
