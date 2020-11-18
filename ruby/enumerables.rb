class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        return self
    end

    def my_select(&prc)
        arr = []
        self.my_each do |e|
            arr << e if prc.call(e)
        end
        arr
    end

    def my_reject(&prc)
        arr = []
        self.my_each do |e|
            arr << e if !prc.call(e)
        end
        arr
    end

    def my_any?(&prc)
        self.my_each do |e|
            return true if prc.call(e)
        end
        return false
    end

    def my_all?(&prc)
        self.my_each do |e|
            return false if !prc.call(e)
        end
        return true
    end

    def my_flatten(arr = [])
        self.my_each do |ele|
            if ele.class == Array
                ele.my_flatten(arr)
            else
                arr << ele
            end
        end

        return arr
    end

    def my_zip(*arrs)
        zipped = Array.new(self.length) { Array.new(arrs.length + 1, nil) }

        arrs.each_with_index do |arr, i|
            if i == zipped[0].length
                break
            end
            arr.each_with_index do |ele, j|
                if j == zipped.length
                    break
                end
                zipped[j][i+1] = ele
            end
        end
        
        zipped.each_with_index do |arr, i|
            arr[0] = self[i]
        end

        return zipped
    end

    def my_rotate(z = 1)
        arr = self.clone
        self.each_with_index do |e, i|
            arr[i] = self[(i + z) % self.length]
        end
        return arr
    end

    def my_join(z = "")
        str = ""
        self.each do |e|
            str += e + z
        end
        return str[0...-1] if str[-1] == z
        return str
    end

    def my_reverse
        arr = []
        i = 0
        while i < self.length
            arr << self[-i]
            i += 1
        end
        arr
    end
end

def factors(num)
    divisors = [1]
        (2...num).each do |n|
            if num % n == 0
                divisors << n
            end
        end
    divisors
end

class Array
    def bubble_sort!(&prc)
        prc ||= Proc.new{ |a, b| a <=> b }

        sorted = false
        while !sorted
            sorted = true
            self.each_with_index do |e, i|
                if prc.call(e, self[i+1]) == 1
                    sorted = false
                    self[i], self[i+1] = self[i+1], self[i]
                end
            end
        end
        return self
    end

    def bubble_sort(&prc)
        arr = self.clone
        prc ||= Proc.new{ |a, b| a <=> b }

        sorted = false
        while !sorted
            sorted = true
            arr.each_with_index do |e, i|
                if prc.call(e, arr[i+1]) == 1
                    sorted = false
                    arr[i], arr[i+1] = arr[i+1], arr[i]
                end
            end
        end
        return arr

    end
end

def substrings(string)
    arr = []
    (0...string.length).each do |i|
        (i...string.length).each do |j|
            arr << string[i..j]
        end
    end
    arr
end

def subwords(word, dictionary)
    arr = []
    (0...string.length).each do |i|
        (i...string.length).each do |j|
            arr << string[i..j] if dictionary.include?(string[i..j])
        end
    end
    arr
end