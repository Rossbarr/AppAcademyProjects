class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    placeholder_int = 0
    self.each_with_index do |el, i|
      placeholder_int += el.hash * i ^ 118112
    end
    return placeholder_int.hash
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    placeholder_int = 0
    self.each_char.with_index do |char, i|
      placeholder_int += alphabet.index(char.downcase) * i ^ 118112
    end
    return placeholder_int.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    placeholder_int = 0
    array = self.to_a.sort!
    array.each do |arr|
      placeholder_int += arr.hash ^ 118112
    end
    placeholder_int.hash
  end
end
