def bad_two_sum?(arr, target)
  i = 0
  j = 1
  while i < arr.length
    while j < arr.length
      if arr[i] + arr[j] == target
        return true
      end
      j += 1
    end
    i += 1
    j = i + 1
  end
  return false
end

arr = [0, 1, 5, 7]
puts bad_two_sum?(arr, 6) # => should be true
puts bad_two_sum?(arr, 10) # => should be false

def okay_two_sum?(arr, target)
  arr.sort!
  i = 0
  j = arr.length - 1
  while i < j
    result = arr[i] + arr[j] <=> target
    if result == 0
      return true
    elsif result == 1
      j -= 1
    elsif result == -1
      i += 1
    end
  end
  return false
end

puts okay_two_sum?(arr, 6)
puts okay_two_sum?(arr, 10)

def two_sum?(arr, target)
  hash = Hash.new
  arr.each do |key|
    if hash[target - key] == true
      return true
    end
    hash[key] = true
  end

  return false
end

puts two_sum?(arr, 6)
puts two_sum?(arr, 10)
