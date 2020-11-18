def prime?(num)
  if num < 2
    return false
  else (2...num).each { |d| return false if num % d == 0 }
  end
  return true
end
