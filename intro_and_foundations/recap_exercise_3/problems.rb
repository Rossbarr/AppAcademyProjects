def no_dupes?(arr)
    new_arr = arr.clone
    (0...arr.length).each do |i|
        (i+1...arr.length).each do |j|
            if arr[i] == arr[j]
                new_arr.delete(arr[i])
            end
        end
    end
    new_arr
    
    # a better solution uses hashes
end

# Examples
# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []


def no_consecutive_repeats?(arr)
    (0...arr.length-1).each do |i|
        if arr[i] == arr[i+1]
            return false
        end
    end
    true
end

# Examples
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true
# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true


def char_indices(str)
    hash = Hash.new { Array.new() }
    str.each_char.with_index { |char, i| hash[char] += [i] }
    hash
end

# Examples
# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}


def longest_streak(str)
    winner = ""
    (0...str.length).each do |i|
        (i...str.length).each do |j|
            if str[j] == str[i] and str[i..j].length >= winner.length
                winner = str[i..j]
            end
        end
    end
    winner
end

# Examples
# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'


def vigenere_cipher(str, arr)
    alpha = ("a".."z").to_a
    str.each_char.with_index do |char, i|
        num = i % arr.length
        str[i] = alpha[(alpha.index(char) + arr[num]) % 26]
    end
    str
end

# Examples
# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"


def vowel_rotate(str)
    new_str = str.clone
    vowels = "aeiou"
    vowels_at = []
    str.each_char.with_index do |c, i|
        if vowels.include?(c)
            vowels_at << i
        end
    end

    vowels_at.each_with_index do |ele, idx|
        if idx == 0
            new_str[ele] = str[vowels_at[-1]]
        else
            new_str[ele] = str[vowels_at[(idx - 1) % vowels_at.length]]
        end
    end
    new_str
end

# Examples
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"
# p vowel_rotate('computer')      # => "cempotur"

class String
    def select(&prc)
        prc ||= Proc.new { |char| false }    
        new_str = ""
        self.each_char do |char|
            new_str += char if prc.call(char)
        end
        new_str
    end

    def map!(&prc)
        self.each_char.with_index do |char, i|
            self[i] = prc.call(char, i)
        end
        self
    end
end


# Examples
# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""


# Examples
# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

def multiply(a, b)
    if b < 0
        sum = -a + multiply(a, b + 1)
    elsif b > 0
        sum = a + multiply(a, b - 1)
    else
        return 0
    end
    sum
end

# Examples
# p multiply(3, 5)        # => 15
# p multiply(5, 3)        # => 15
# p multiply(2, 4)        # => 8
# p multiply(0, 10)       # => 0
# p multiply(-3, -6)      # => 18
# p multiply(3, -6)       # => -18
# p multiply(-3, 6)       # => -18

def lucas_sequence(n)
    if n == 0
        return []
    elsif n == 1
        return [2]
    elsif n == 2
        return [2, 1]
    end
    prev_seq = lucas_sequence(n-1)
    prev_seq + [prev_seq[-1] + prev_seq[-2]]
end

# Examples
# p lucas_sequence(0)   # => []
# p lucas_sequence(1)   # => [2]    
# p lucas_sequence(2)   # => [2, 1]
# p lucas_sequence(3)   # => [2, 1, 3]
# p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
# p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

def prime?(n)
    return false if n < 2
    (2..n/2).each { |e| return false if n%e == 0}
    true
end

def prime_factorization(n)
    return [n] if prime?(n)
    arr = []
    (2...n).each do |e|
        if n % e == 0 and prime?(e)
            arr << e
            break
        end
    end
    arr += prime_factorization(n/arr[0])
    return arr
end

# Examples
# p prime_factorization(12)     # => [2, 2, 3]
# p prime_factorization(24)     # => [2, 2, 2, 3]
# p prime_factorization(25)     # => [5, 5]
# p prime_factorization(60)     # => [2, 2, 3, 5]
# p prime_factorization(7)      # => [7]
# p prime_factorization(11)     # => [11]
# p prime_factorization(2017)   # => [2017]