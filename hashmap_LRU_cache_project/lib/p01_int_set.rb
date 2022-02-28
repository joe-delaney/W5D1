class MaxIntSet
  BOUNDARY_ERROR = "Out of bounds"

  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise BOUNDARY_ERROR unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise BOUNDARY_ERROR unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise BOUNDARY_ERROR unless is_valid?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    !(num < 0 || num >= @store.length)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
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
    unless self.include?(num)
      self[num] << num
      @count += 1
    end
    resize! if @count >= num_buckets
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num) 
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    idx = num % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        temp[num % temp.length] << num
      end
    end
    @store = temp
  end
end
