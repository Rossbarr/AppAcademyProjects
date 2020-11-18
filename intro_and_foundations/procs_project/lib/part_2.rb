def reverser(str, &prc)
    prc.call(str.reverse)
end

def word_changer(str, &prc)
    arr = str.split(" ").map { |ele| prc.call(ele) }
    arr.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    return prc1.call(num) if prc1.call(num) >= prc2.call(num)
    prc2.call(num)
end

def and_selector(arr, prc1, prc2)
    arr.select { |ele| prc1.call(ele) and prc2.call(ele) }
end

def alternating_mapper(arr, prc1, prc2)
    new_arr = []
    arr.each_with_index do |ele, idx|
        if idx % 2 == 0
            new_arr << prc1.call(ele)
        else
            new_arr << prc2.call(ele)
        end
    end
    new_arr
end