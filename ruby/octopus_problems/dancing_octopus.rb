
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
