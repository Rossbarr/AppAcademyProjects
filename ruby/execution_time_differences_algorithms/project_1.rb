def my_min(array)
  result = 0
  array.each do |num1|
    array.all? do |num2|
      if num1 <= num2
        result = num1
      end
    end
  end
  return result
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
puts my_min(list)  # =>  -5

def better_my_min(array)
  min = array[0]
  array.each do |number|
    if number < min
      min = number
    end
  end
  return min
end

puts better_my_min(list)

def largest_contiguous_sum(array)
  sub_arrays = []
  array.index do |i|
    array.index do |j|
      sub_arrays << array[i..j]
    end
  end

  max = sub_arrays[0].sum
  sub_arrays.each do |array|
    if max < array.sum
      max = array.sum
    end
  end

  return max
end
