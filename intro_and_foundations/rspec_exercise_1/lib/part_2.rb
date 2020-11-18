def hipsterfy(word)
    vowels = "aeiouAEIOU"
    i = -1
    while !word[i].nil?
        if vowels.include?(word[i])
            return word[0...i] + word[i+1..-1]
        else
            i -= 1
        end
    end
    word
end

def vowel_counts(str)
    vowels = "aeiouAEIOU"
    hash = Hash.new(0)
    str.each_char do |char|
        if vowels.include?(char)
            hash[char.downcase] += 1
        end
    end
    hash
end

def caesar_cipher(str, n)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    str.each_char.with_index do |char, idx|
        if alphabet.include?(char) 
            str[idx] = alphabet[(alphabet.index(char) + n) % 26]
        end
    end
    str
end

puts caesar_cipher("hello", 5)