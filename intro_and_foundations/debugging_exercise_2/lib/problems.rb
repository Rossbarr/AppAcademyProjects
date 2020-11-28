# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"

def largest_prime_factor(num)
  num.downto(2) { |factor| return factor if prime?(factor) and num % factor == 0 }
end

def prime?(num)
  return false if num < 2
  (2...num).none? { |factor| num % factor == 0 }
end

def unique_chars?(string)
  string.each_char.with_index do |char, i|
    if string[i+1..-1].include?(char)
      return false
    end
  end
  true
end

def dupe_indices(array)
  hash = Hash.new(nil)
  array.each_with_index do |ele, i|
    if array[0...i].include?(ele) or array[i+1..-1].include?(ele)
      if hash[ele].nil?
        arr = [i]
        hash[ele] = arr
      else
        hash[ele] << i
      end
    end
  end
  hash
end

def ana_array(arr1, arr2)
  arr1.each do |ele|
    if !arr2.include?(ele)
      return false
    end
  end

  arr2.each do |ele|
    if !arr1.include?(ele)
      return false
    end
  end

  true
end
