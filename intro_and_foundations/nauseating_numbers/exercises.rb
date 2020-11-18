def strange_sums(arr)
    count = 0
    arr.each do |ele|
        count += 1 if arr.any? { |e| ele + e == 0 and e != ele }
    end
    count/2
end

# p strange_sums([2, -3, 3, 4, -2])     # 2
# p strange_sums([42, 3, -1, -42])      # 1
# p strange_sums([-5, 5])               # 1
# p strange_sums([19, 6, -3, -20])      # 0
# p strange_sums([9])                   # 0

def pair_product(arr, num)
    count = 0
    arr.each do |ele|
        return true if arr.any? { |e| ele * e == num and e != ele }
    end
    false
end

# p pair_product([4, 2, 5, 8], 16)    # true
# p pair_product([8, 1, 9, 3], 8)     # true
# p pair_product([3, 4], 12)          # true
# p pair_product([3, 4, 6, 2, 5], 12) # true
# p pair_product([4, 2, 5, 7], 16)    # false
# p pair_product([8, 4, 9, 3], 8)     # false
# p pair_product([3], 12)             # false

def rampant_repeats(word, hash)
    new_word = ""
    word.each_char do |char|
        if hash[char]
            new_word += char * hash[char]
        else
            new_word += char
        end
    end
    new_word
end

# p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
# p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
# p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
# p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'

def perfect_square(num)
    (2..num/2).each do |d|
        return true if d*d == num
    end
    num < 2
end

# p perfect_square(1)     # true
# p perfect_square(4)     # true
# p perfect_square(64)    # true
# p perfect_square(100)   # true
# p perfect_square(169)   # true
# p perfect_square(2)     # false
# p perfect_square(40)    # false
# p perfect_square(32)    # false
# p perfect_square(50)    # false

def num_divisors(num)
    (1...num).count { |e| num % e == 0 }
end

def anti_prime?(num)
    num_d = num_divisors(num)
    (1...num).each do |e|
        return false if num_d <= num_divisors(e)
    end
    true
end

# p anti_prime?(24)   # true
# p anti_prime?(36)   # true
# p anti_prime?(48)   # true
# p anti_prime?(360)  # true
# p anti_prime?(1260) # true
# p anti_prime?(27)   # false
# p anti_prime?(5)    # false
# p anti_prime?(100)  # false
# p anti_prime?(136)  # false
# p anti_prime?(1024) # false

def matrix_addition(a, b)
    c = Array.new(a.length) { Array.new(a[0].length) }
    x = y = 0
    while x < c.length
        while y < c[0].length
            c[x][y] = a[x][y] + b[x][y]
            y += 1
        end
        x += 1
        y = 0
    end
    c
end

matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
# p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
# p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
# p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]

def mutual_factors(*nums)
    arr = []
    (1..nums.min).each do |d|
        if nums.all? { |num| num % d == 0 }
            arr << d
        end
    end
    arr
end

# p mutual_factors(50, 30)            # [1, 2, 5, 10]
# p mutual_factors(50, 30, 45, 105)   # [1, 5]
# p mutual_factors(8, 4)              # [1, 2, 4]
# p mutual_factors(8, 4, 10)          # [1, 2]
# p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
# p mutual_factors(12, 24, 64)        # [1, 2, 4]
# p mutual_factors(22, 44)            # [1, 2, 11, 22]
# p mutual_factors(22, 44, 11)        # [1, 11]
# p mutual_factors(7)                 # [1, 7]
# p mutual_factors(7, 9)              # [1]

def tribonacci_number(num)
    if num == 1
        return 1
    elsif num == 2
        return 1
    elsif num == 3
        return 2
    end

    return tribonacci_number(num - 1) + tribonacci_number(num - 2) + tribonacci_number(num - 3)
end

# p tribonacci_number(1)  # 1
# p tribonacci_number(2)  # 1
# p tribonacci_number(3)  # 2
# p tribonacci_number(4)  # 4
# p tribonacci_number(5)  # 7
# p tribonacci_number(6)  # 13
# p tribonacci_number(7)  # 24
# p tribonacci_number(11) # 274

def matrix_addition_reloaded(*arrs)
    return nil if !arrs.all? { |arr| arr.length == arrs[0].length and arr[0].length == arrs[0][0].length }
    arrs.inject { |i, e| matrix_addition(i, e) }
end

# p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
# p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
# p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
# p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

def squarocol?(matrix)
    matrix.each do |arr|
        return true if arr.all? { |ele| ele == arr[0] }
    end

    matrix.transpose.each do |arr|
        return true if arr.all? { |ele| ele == arr[0] }
    end

    false
end

# p squarocol?([
#     [:a, :x , :d],
#     [:b, :x , :e],
#     [:c, :x , :f],
# ]) # true

# p squarocol?([
#     [:x, :y, :x],
#     [:x, :z, :x],
#     [:o, :o, :o],
# ]) # true

# p squarocol?([
#     [:o, :x , :o],
#     [:x, :o , :x],
#     [:o, :x , :o],
# ]) # false

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 7],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # true

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 0],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # false

def squaragonal?(matrix)
    arr = []
    (0...matrix.length).each { |i| arr << matrix[i][i] }
    return true if arr.all? { |e| e == arr[0] }

    arr = []
    (0...matrix.length).each { |i| arr << matrix[i][matrix.length - 1 - i] }
    return true if arr.all? { |e| e == arr[0] }

    false
end

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :x, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :o, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 7],
#     [1, 1, 6, 7],
#     [0, 5, 1, 7],
#     [4, 2, 9, 1],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 5],
#     [1, 6, 5, 0],
#     [0, 2, 2, 7],
#     [5, 2, 9, 7],
# ]) # false

def pascals_triangle(num)
    return [[1]] if num == 1

    tri = pascals_triangle(num-1)
    arr = []
    i = 0
    while i < num
        if i == 0 or i == (num - 1)
            arr << 1
        else
            arr << tri[-1][i-1] + tri[-1][i]
        end
        i += 1
    end
    tri << arr
    tri
end

# p pascals_triangle(5)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1]
# # ]

# p pascals_triangle(7)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1],
# #     [1, 5, 10, 10, 5, 1],
# #     [1, 6, 15, 20, 15, 6, 1]
# # ]

def prime?(num)
    (2...num/2).each { |e| return false if num % e == 0 }
    num > 2
end

def mersenne_prime(num)
    i = 1
    while num > 0
        if prime?(2*i - 1)
            num -= 1
        end
        i = 2*i
    end
    i - 1
end

# p mersenne_prime(1) # 3
# p mersenne_prime(2) # 7
# p mersenne_prime(3) # 31
# p mersenne_prime(4) # 127
# p mersenne_prime(6) # 131071

def triangular_word?(str)
    alpha = ("a".."z").to_a

    sum = 0
    str.each_char { |c| sum += alpha.index(c) + 1 }

    i = 1
    while true
        if sum == (i * (i+1)) / 2
            return true
        elsif sum < (i * (i+1)) / 2
            return false
        end
        i += 1
    end
end

# p triangular_word?('abc')       # true
# p triangular_word?('ba')        # true
# p triangular_word?('lovely')    # true
# p triangular_word?('question')  # true
# p triangular_word?('aa')        # false
# p triangular_word?('cd')        # false
# p triangular_word?('cat')       # false
# p triangular_word?('sink')      # false

def consecutive_collapse(arr)
    collapsable = true
    while collapsable
        collapsable = false
        arr.each_with_index do |ele, i|
            if (ele + 1 == arr[i+1]) or (ele - 1 == arr[i+1])
                arr.delete_at(i)
                arr.delete_at(i)
                collapsable = true
                break
            end
        end
    end
    arr
end

# p consecutive_collapse([3, 4, 1])                     # [1]
# p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
# p consecutive_collapse([9, 8, 2])                     # [2]
# p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
# p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
# p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
# p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
# p consecutive_collapse([13, 11, 12, 12])              # []

def pretentious_primes(arr, num)
    new_arr = []
    if num > 0
        arr.each do |ele|
            i = 0
            j = 1
            while i < num
                if prime?(ele+j)
                    i += 1
                end
                j += 1
            end
            new_arr << (ele + j - 1)
        end
    elsif num < 0
        arr.each do |ele|
            whatever = false
            i = 0
            j = -1
            while i > num
                if prime?(ele+j)
                    i -= 1
                elsif (ele+j) < 2
                    whatever = true
                    break
                end
                j -= 1
            end
            if whatever
                new_arr << nil
            else
                new_arr << (ele + j + 1)
            end
        end
    end
    new_arr
end

# p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
# p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
# p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
# p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
# p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
# p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
# p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
# p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
# p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
# p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]