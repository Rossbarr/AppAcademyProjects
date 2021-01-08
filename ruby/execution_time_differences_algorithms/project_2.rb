def first_anagram?(word1, word2)
  arr1 = word1.split("")
  all_perms = arr1.permutation.to_a
  all_perms.each do |perm|
    if perm.join("") == word2
      return true
    end
  end
  return false
end

puts first_anagram?("elvis", "lives")
puts first_anagram?("gizmo", "sally")

def second_anagram?(word1, word2)
  (0...word1.length).each do |i|
    begin
      word2.slice!(word2.index(word1[i]))
    rescue
      return false
    end
  end
  word2.length == 0
end

puts second_anagram?("elvis", "lives")
puts second_anagram?("gizmo", "sally")

def third_anagram?(word1, word2)
  word1.chars.sort == word2.chars.sort
end

puts third_anagram?("elvis", "lives")
puts third_anagram?("gizmo", "sally")

def fourth_anagram?(word1, word2)
  if word1.length != word2.length
    return false
  end

  letters = Hash.new { |h,k| h[k] = 0 }
  (0...word1.length).each do |i|
    letters[word1[i]] += 1
    letters[word2[i]] -= 1
  end

  letters.each do |key, value|
    if value != 0
      return false
    end
  end

  return true
end

puts fourth_anagram?("elvis", "lives")
puts fourth_anagram?("gizmo", "sally")
