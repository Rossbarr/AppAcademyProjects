def range_rec(start, last)
  return [] if last <= start
  [start] + range_rec(start+1, last)
end

def range_iter(start, last)
  arr = []
  while start < last
    arr << start
    start += 1
  end
  return arr
end

def exponentiation_1(b, n)
  return nil if n < 0
  return 1 if n == 0
  b * exponentiation_1(b, n-1)
end

def exponentiation_2(b, n)
  return nil if n < 0
  return 1 if n == 0
  return b if n == 1
  if n.even?
    return exponentiation_2(b, n/2) * exponentiation_2(b, n/2)
  elsif n.odd?
    return b * exponentiation_2(b, (n-1)/2) * exponentiation_2(b, (n-1)/2)
  end
end

class Array
  def deep_dup
    arr = []
    self.each do |ele|
      if ele.is_a?(Array)
        arr << ele.deep_dup
      else
        arr << ele
      end
    end
    return arr
  end
end

def fibonacci(n)
  return [1] if n == 1
  return [1, 2] if n == 2
  seq = fibonacci(n-1)
  seq << seq[-1] + seq[-2]
  return seq
end

def bsearch(array, target)
  return nil if array.length == 0
  mid = array.length/2
  if target == array[mid]
    return mid
  elsif target > array[mid]
    val = bsearch(array[mid+1..-1], target)
    return nil if val == nil
    return val + mid + 1
  else
    return bsearch(array[0...mid], target)
  end
end

def merge_sort(array)
  return array if array.length <= 1
  mid = array.length/2
  merge(merge_sort(array[0...mid]), merge_sort(array[mid..-1]))
end

def merge(arr1, arr2)
  sorted = []
  i = 0
  j = 0
  while i < arr1.length and j < arr2.length 
    if arr1[i] <= arr2[j]
      sorted << arr1[i]
      i += 1
     else
      sorted << arr2[j]
      j += 1
    end
  end
  
  if i == arr1.length
    arr2[j..-1].each { |e| sorted << e }
  else
    arr1[i..-1].each { |e| sorted << e }
  end
  return sorted
end

def subsets(arr)
  return [] if arr.length == 0
  return [[], [arr[0]]] if arr.length == 1
  array = []
  
  subsets(arr[0...-1]).each do |e|
    array << e if !array.include?(e)
  end

  placeholder = []
 
  array.each do |ele|
    curr = ele.deep_dup
    curr << arr[-1]
    placeholder << curr if !array.include?(curr)
  end
 
  placeholder.each do |ele|
    array << ele
  end

  return array
end

def permutations(array)
  return array if array.length <= 1
  return [[array[0], array[1]], [array[1], array[0]]] if array.length == 2
  arr = []

  i = 0
  while i < array.length
    point = [array[i]]
    rest = array[0...i] + array[i+1..-1]
    permutations(rest).each do |ele|
      arr << point + ele if !arr.include?(point + ele)
      arr << ele + point if !arr.include?(ele + point)
    end
    i += 1
  end
  arr
end

def greedy_make_change(amt, coins)
  biggest = coins[0]
  rest = coins[1..-1]
  coins = []
  while amt - biggest >= 0
    amt = amt - biggest
    coins << biggest
  end

  if amt == 0
    return coins
  else
    return coins + greedy_make_change(amt, rest)
  end
end

def make_better_change(amt, coins)
  if amt <= 0
    return []
  end
  best = Array.new(amt, 1)
  coins.each do |coin|
    rest = coins.select{ |c| c <= coin }
    if amt - coin == 0
      return [coin]
    elsif amt - coin > 0
      arr = [coin] + make_better_change(amt - coin, rest)
      if arr.length < best.length
        best = arr
      end
    end
  end
  return best
end
