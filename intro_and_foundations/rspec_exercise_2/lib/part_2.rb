def palindrome?(str)
    i = 0
    while i < str.length - 1
        if str[i] != str[-i-1]
            return false
        end
        i += 1
    end
    true
end

def substrings(str)
    j = 0
    k = 0
    arr = []
    while j < str.length - 1
        arr << str[j..k]
        if k != str.length - 1
            k += 1
        else
            j += 1
            k = j
        end
    end
    arr << str[-1]
    arr
end

def palindrome_substrings(str)
    substrings(str).select { |ele| ele.length > 1 and palindrome?(ele) }
end