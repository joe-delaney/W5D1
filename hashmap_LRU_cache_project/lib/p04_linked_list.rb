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

    #connect the previous node to the next node
    #connect the next node to the previous node
    #set next and prev equal to nil
    self.prev.next = self.next 
    self.next.prev = self.prev
    self.prev = nil 
    self.next = nil
  end
end

class LinkedList
include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Node.new()
    @tail = Node.new()
    @head.next = tail
    @tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail && tail.prev == head
  end

  def get(key)
    current_node = head.next 
    while current_node != tail 
      if current_node.key == key 
        return current_node.val
      end 
      current_node = current_node.next
    end
    nil
  end

  def include?(key)
    current_node = head.next 
    while current_node != tail 
      if current_node.key == key 
        return true 
      end 
      current_node = current_node.next
    end
    return false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.next = tail 
    new_node.prev = last
    last.next = new_node
    tail.prev = new_node
  end

  def update(key, val)
    current_node = head.next 
    while current_node != tail 
      if current_node.key == key 
        current_node.val = val
        return true 
      end 
      current_node = current_node.next
    end
    return false
  end

  def remove(key)
    current_node = head.next 
    while current_node != tail 
      if current_node.key == key 
        current_node.remove
        break
      end 
      current_node = current_node.next
    end
    nil
  end

  def each(&prc)
    current_node = head.next 
    while current_node != tail 
      prc.call(current_node)
      current_node = current_node.next
    end
  end

  #uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
