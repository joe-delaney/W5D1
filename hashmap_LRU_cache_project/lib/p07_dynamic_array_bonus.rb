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
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
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
    if i >= @count && i < -@count
      return nil 
    elsif i < 0
      i = @store.length + i
    end
    @store[i]
  end

  def []=(i, val)
    i = @store.length + i if i < 0
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    (0...@store.length).each do |i|
      return true if @store[i] == val 
    end
    false
  end

  def push(val)
    resize! if count == capacity
    @store[count] = val
    @count += 1
  end

  # require "byebug"
  def unshift(val)
    # debugger
    resize! if count+1 == capacity
    temp = StaticArray.new(capacity)
    temp[0] = val
    i = 1
    self.each_with_index do |ele|
      temp[i] = ele if i != capacity
      i+=1
    end
    @store = temp
    @count += 1
  end

  def pop
    return nil if @store[0].nil?
    i = 0
    until @store[i].nil? || i == @store.length
      i += 1
    end
    temp = @store[i-1]
    @store[i-1] = nil
    @count -= 1
    temp
  end

  def shift
    temp = StaticArray.new(@store.length)
    shifted_ele = first
    (0...@store.length-1).each do |i|
      temp[i] = @store[i+1]
    end
    @store = temp
    @count -= 1
    shifted_ele
  end

  def first
    @store[0]
  end

  def last
    i = 0
    until @store[i].nil? || i == @store.length
      i += 1
    end
    @store[i-1]
  end

  def each
    (0...@store.length).each {|i| yield(@store[i])}
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false if length != other.length
    self.each_with_index do |ele, i|
      return false unless ele == other[i]
    end
    return true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    temp = StaticArray.new(capacity * 2)
    (0...capacity).each do |i|
      temp[i] = @store[i]
    end
    @store = temp
  end
end
