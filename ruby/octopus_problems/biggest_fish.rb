def sluggish(array)
  array.each do |fish1|
    if array.all? { |fish2| fish1.length >= fish2.length }
      return fish1
    end
  end
end

def dominant(array)
  sort(array)[-1]
end

def sort(array)
  if array.length <= 1
    return array
  end

  left = sort(array[0...array.length/2])
  right = sort(array[array.length/2..-1])

  merge(left, right)
end

def merge(left, right)
  result = []

  i = j = 0
  while i < left.length and j < right.length
    if left[i].length > right[j].length
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end

  result
end

def clever(array)
  longest_fish = array[0]
  array.each do |fish|
    if fish.length > longest_fish.length
      longest_fish = fish
    end
  end

  return longest_fish
end
