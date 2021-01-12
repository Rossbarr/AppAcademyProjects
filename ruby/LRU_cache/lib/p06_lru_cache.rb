require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      node = @map.get(key)
      update_node!(node)
      return node.val
    else
      return calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    pointer = @store.append(key, val)
    @map.set(key, pointer)

    if count > @max
      eject!
    end
 
    return val    
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.last.next = node
    node.prev = @store.last
    @store.tail.prev = node
    node.next = @store.tail

  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
  end
end
