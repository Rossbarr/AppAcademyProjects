#Problem 1: 

def sum_recur(array)
  return 0 if array.length < 1
  return array[0] if array.length == 1
  array[0] + sum_recur(array[1..-1])
end

puts "sum_recur tests"
puts "expect: 0, 1, 55"

p sum_recur([])
p sum_recur([1])
p sum_recur([1,2,3,4,5,6,7,8,9,10])

#Problem 2: 

def includes?(array, target)
  return false if array.length == 0
  return true if array[0] == target
  includes?(array[1..-1], target)
end

puts "includes? test"
puts "expect: true, true, false"

p includes?([3, 5, 7], 7)
p includes?([3, 7, 5], 7)
p includes?([3, 7, 5], 4)

# Problem 3: 

def num_occur(array, target)
  return 0 if array.length == 0
  count = 0
  if array[0] == target
    count = 1
  end
  return count + num_occur(array[1..-1], target)
end

puts "num_occur test"
puts "expect: 0, 1, 6"

p num_occur([1, 3, 6, 8], 2)
p num_occur([1, 3, 7, 8, 2, 3], 2)
p num_occur([1, 2, 1, 3, 1, 7, 1, 1, 1], 1) 

# Problem 4: 

def add_to_twelve?(array)
  return false if array.length < 2
  return true if array[0] + array[1] == 12
  add_to_twelve?(array[1..-1])
end

puts "add_to_twelve? test"
puts "expect: true, false"

p add_to_twelve?([6, 5, 2, 10, 7])
p add_to_twelve?([6, 5, 3, 2, 1, 9, 5])

# Problem 5: 

def sorted?(array)
  return true if array.length < 2
  return false if array[0] > array[1]
  sorted?(array[1..-1])
end

puts "sorted? test"
puts "expect: true, false"

p sorted?([1, 2, 3, 4, 7, 9, 10])
p sorted?([1, 2, 4, 3, 9, 7, 10])

# Problem 6: 

def reverse(string)
  return string if string.length < 2
  reverse(string[1..-1]) + string[0]
end

puts "reverse test"

p reverse("Kat")
p reverse("Racecar")
