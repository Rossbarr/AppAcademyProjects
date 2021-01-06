
def slow_dance(move)
  array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
  i = 0
  while i < array.length
    if move == array[i]
      return i
    else
      i += 1
    end
  end
  return -1
end

def fast_dance(move)
  # I know creating the hash like this slows this method to O(n) time,
  # but I'm too lazy to create the hash by hand, lol.
  # At least I understand that hashes are O(1), right?
  array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
  hash = {}
  array.each_with_index do |movement, i|
    hash[movement] = i
  end

  return hash[move]
end
