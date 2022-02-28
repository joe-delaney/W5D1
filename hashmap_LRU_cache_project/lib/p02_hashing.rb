class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    #hash each element with its index to avoid returning same value for 
    #reordered arrays
    temp = self.each_with_index.map{|ele, i| ele.hash + i.hash}

    #Set an accumulator starting with 0
    accumulator = 0

    #return 0 if the array is empty
    return accumulator if self.length == 0

    #Use inject to XOR each hashed element and return the ending accumulator
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
    #Convert the hash to an array and use the array hash defined above
    #Sort the hash by keys to produce the same value for a reordering of the 
    #same hash.
    self.to_a.sort_by {|k,v| k}.hash
  end
end
