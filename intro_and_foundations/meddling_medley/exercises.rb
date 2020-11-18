def duos(str)
    count = 0
    str.each_char.with_index do |e, i|
        count += 1 if str[i+1] == e
    end
    count
end

# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0

def sentence_swap(sent, hash)
    arr = sent.split(" ").map do |word|
        if hash[word]
            hash[word] 
        else
            word
        end
    end
    arr.join(" ")
end

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'

def hash_mapped(hash, prc, &blc)
    new_hash = Hash.new { |h,k| h[k] = nil }
    hash.each do |k, v|
        new_hash[blc.call(k)] = prc.call(v)
    end
    new_hash
end

# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}

def counted_characters(str)
    hash = Hash.new(0)
    str.each_char do |c|
        hash[c] += 1
    end
    arr = []
    hash.each { |k,v| arr << k if v > 2 }
    arr
end

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []

def triplet_true(str)
    str.each_char.with_index do |c, i|
        return true if str[i+1] == c and str[i+2] == c
    end
    false
end

# p triplet_true('caaabb')        # true
# p triplet_true('terrrrrible')   # true
# p triplet_true('runninggg')     # true
# p triplet_true('bootcamp')      # false
# p triplet_true('e')             # false

def energetic_encoding(str, hash)
    a = str.split("").map do |c|
        if hash[c]
            hash[c]
        elsif c == " "
            " "
        else
            '?'
        end
    end
    a.join("")
end

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'

def uncompress(str)
    new_str = ""
    str.each_char.with_index do |c, i|
        if i.even?
            new_str += c * str[i+1].to_i
        end
    end
    new_str
end

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'

def conjunct_select(arr, *prcs)
    arr.select { |e| prcs.all? { |prc| prc.call(e) } }
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def convert_pig_latin(str)
    words = str.split(" ")
    vowels = "aeiou"
    arr = []
    words.map do |word|
        word.each_char.with_index do |c, i|
            if word.length < 3
                arr << word
                break
            elsif vowels.include?(c) and i == 0
                arr << word + "yay"
                break
            elsif vowels.include?(c)
                arr << word[i..-1] + word[0...i] + "ay"
                break
            end
        end
    end
    arr.join(" ")
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(str)
    words = str.split(" ")
    vowels = "aeiou"
    arr = []
    last_vowel = 0
    words.map do |word|
        word.each_char.with_index do |c, i|
            if vowels.include?(c)
                last_vowel = i
            end

            if word.length < 3
                arr << word
                break
            elsif vowels.include?(c) and i == (word.length - 1)
                arr << word + word
                break
            elsif !vowels.include?(c) and i == (word.length - 1)
                arr << word + word[last_vowel..-1]
                break
            end
        end
    end
    arr.join(" ")
end

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
    new_arr = []
    arr.each do |ele|
        prcs.each do |prc|
            if prc.call(ele)
                new_arr << ele 
                break
            end
        end
    end
    new_arr
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

def alternating_vowel(str)
    vowels = "aeiou"
    arr = []
    last_i = 0
    str.split(" ").each_with_index do |word, i|
        word.each_char.with_index do |c, idx|
            if i.even?
                if vowels.include?(c)
                    arr << word[0...idx] + word[idx+1..-1]
                    break
                end
            elsif i.odd?
                if vowels.include?(word[word.length - 1 - idx])
                    arr << word[0...(word.length - 1 - idx)] + word[(word.length - idx)..-1]
                    break
                end
            end
        end
    end
    arr.join(" ")
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_talk(str)
    vowels = "aeiou"
    arr = []
    curr = ""
    str.split(" ").each do |word|
        curr = word
        counter = 0
        word.each_char.with_index do |c, i|
            if vowels.include?(word[-1])
                curr = word + word[-1]
                break
            else
                if vowels.include?(c.downcase)
                    curr = curr[0..i+counter] + "b" + curr[i+counter..-1].downcase
                    counter += 2
                end
            end
        end
        arr << curr
    end
    arr.join(" ")
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)
    new_str = ""
    i = 0
    count = 1
    while i < str.length
        char = str[i]
        if str[i+count] == char
            count += 1
        else
            if count == 1
                new_str += char
            else
                new_str += char + count.to_s
            end
            i += count
            count = 1
        end
    end
    new_str
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"