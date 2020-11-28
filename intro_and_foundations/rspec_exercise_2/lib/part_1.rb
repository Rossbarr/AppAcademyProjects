def partition(arr, num)
    arr1 = []
    arr2 = []
    arr.each do |ele|
        if ele < num
            arr1 << ele
        else
            arr2 << ele
        end
    end
    [arr1, arr2]
end

def merge(hash1, hash2)
    new_hash = Hash.new()
    hash1.each { |k, v| new_hash[k] = v }
    hash2.each { |k, v| new_hash[k] = v }
    new_hash
end

def censor(sentence, curses)
    vowels = "aeiou"
    words = sentence.split(" ")
    words.each_with_index do |word, index|
        if curses.include?(word.downcase)
            words[index] = word.each_char.with_index { |char, idx| word[idx] = '*' if vowels.include?(char.downcase) }
        end
    end
    words.join(" ")
end

def power_of_two?(num)
    product = 1
    while product < num
        product *= 2
    end
    product == num
end