def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum/arr.length.to_f
end

def repeat(str, num)
    str * num
end

def yell(str)
    str.upcase + "!"
end

def alternating_case(str)
    arr = str.split(" ")
    new_arr = arr.map.with_index do |word, index|
        if index.even?
            word.downcase
        else
            word.upcase
        end
    end
    new_arr.join(" ")
end