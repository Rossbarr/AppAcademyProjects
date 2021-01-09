def windowed_max_range(array, window_size)
  current_max_range = 0
  i = 0
  while i + window_size <= array.length
    difference = array[i...i+window_size].max - array[i..i+window_size].min
    if difference > current_max_range
      current_max_range = difference
    end
    i += 1
  end
  return current_max_range
end

puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) # 4, 8
puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
