def bad_two_sum?(arr, target)
  i = j = 0
  while i < arr.length
    while j < arr.length
      if arr[i] + arr[j] == target
        return true
      end
      j += 1
    end
    i += 1
    j = i
  end
  return false
end

arr = [0, 1, 5, 7]
two_sum?(arr, 6) # => should be true
two_sum?(arr, 10) # => should be false
