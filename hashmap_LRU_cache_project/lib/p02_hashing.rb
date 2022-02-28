class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    temp = self.each_with_index.map{|ele, i| ele.hash + i.hash}
    accumulator = 0
    return accumulator if self.length == 0
    temp.inject do |accumulator, ele|
      accumulator ^ ele
    end
  end
end

class String
  def hash
    #ord is the same as to_i, but for single characters instead of strings
    self.chars.map {|char| char.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort_by {|k,v| k}.hash
  end
end
