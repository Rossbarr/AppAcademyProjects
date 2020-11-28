def select_even_nums(arr)
  arr.select(&:even?)
end

def reject_puppies(arr)
  arr.reject { |hash| hash["age"] <= 2 }
end

def count_positive_subarrays(arr_2d)
  arr_2d.count { |arr| arr.sum > 0 }
end

def aba_translate(str)
  vowels = "aeiou"
  p = 0
  str.each_char.with_index do |char, i|
    if vowels.include?(char.downcase)
      str = str[0...i+p] + char + "b" + str[i+p..-1]
      p += 2
    end
  end
  str
end

def aba_array(arr)
  arr.map { |word| aba_translate(word) }
end