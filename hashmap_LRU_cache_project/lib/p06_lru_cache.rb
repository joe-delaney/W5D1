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
    if @map.include?(key) #If key is in map, node exists in cache
      #Move the node to the end of the list before returning its value
      update_node!(@map.get(key))
      return @map.get(key).val
    else #node does not yet exist in the cache  
      value = calc!(key)
      eject! if @map.count > @max 
      return value
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    #call the proc and compute the key's value
    value = @prc.call(key)

    #Append the key-value pair to the linked list
    new_node = @store.append(key, value)

    #Add the key to the hash, along with a pointer to the new node
    @map.set(key, new_node)
    value
  end

  def update_node!(node)
    #remove node from list
    node.remove

    #insert node at end of list
    node.next = @store.tail
    node.prev = @store.last
    @store.last.next = node 
    @store.tail.prev = node 
  end

  def eject!
    #save the key of the element being removed
    key = @store.first.key
    
    #remove the oldest (first) element from the linked list
    @store.first.remove

    #remove the related key from the hash map
    @map.delete(key)
  end
end
