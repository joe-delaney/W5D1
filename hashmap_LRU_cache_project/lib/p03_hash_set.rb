class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      self[key] << key
      @count += 1
    end
    resize! if @count >= num_buckets
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key) 
      @count -= 1
    end
  end

  private
  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    idx = key.hash % num_buckets
    @store[idx]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = Array.new(num_buckets * 2) {Array.new}
    @store.each do |bucket|
      bucket.each do |num|
        temp[num.hash % temp.length] << num
      end
    end
    @store = temp
  end
end
