require "benchmark"

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

def better_my_min(array)
  min = array[0]
  array.each do |number|
    if number < min
      min = number
    end
  end
  return min
end

def largest_contiguous_subsum(array)
  sub_arrays = []
  i = j = 0
  while i < array.length
    while j < array.length
      sub_arrays << array[i..j]
      j += 1
    end
    i += 1
    j = i
  end

  max = sub_arrays[0].inject(0){|sum, x| sum + x }
  sub_arrays.each do |array|
    sum = array.inject(0){|sum, x| sum + x}
    if max < sum
      max = sum
    end
  end

  return max
end

def better_lcs(list)
  sum = list[0]
  curr = 0
  
  i = 0
  while i < list.length
    curr = 0 if curr < 0
    curr += list[i]
    sum = curr if sum < curr
    i += 1
  end

  return sum
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

n = 10000
Benchmark.bm do |x|
  x.report("my_min:   ") { my_min(list) }

  x.report("b_my_min: ") { better_my_min(list) }

  x.report("lcs:      ") { largest_contiguous_subsum(list) }

  x.report("b_lcs:    ") { better_lcs(list) }
end

