# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
    def span
        if !self.all? { |ele| ele.is_a? Numeric } or self.length == 0
            return nil
        else
            return self.max - self.min
        end
    end

    def average
        if !self.all? { |ele| ele.is_a? Numeric } or self.length == 0
            return nil
        else
            return self.sum(0.0)/self.length
        end
    end

    def median
        if self.all? { |ele| ele.is_a? Numeric } and self.length != 0
            if self.length.even?
                return [self.sort[length/2 - 1], self.sort[length/2]].average
            else
                return self.sort[length/2]
            end
        end
        nil
    end

    def counts
        hash = Hash.new { |h, k| h[k] = 0 }
        self.each do |ele|
            hash[ele] += 1
        end
        hash
    end

    def my_count(value)
        count = 0
        self.each { |ele| count += 1 if ele == value }
        count
    end

    def my_index(value)
        self.each_with_index { |ele, i| return i if ele == value }
        nil
    end
    
    def my_uniq
        new_arr = []
        self.each do |ele|
            if !new_arr.include?(ele)
                new_arr << ele
            end
        end
        new_arr
    end

    def my_transpose
        x = self.length
        y = self[0].length
        arr = Array.new(y){Array.new(x, nil)}
        i_x = 0
        i_y = 0

        while true
            arr[i_y][i_x] = self[i_x][i_y]
            if i_x == x-1 and i_y == y-1
                return arr                    
            elsif i_x == x-1
                i_x = 0
                i_y += 1
            else
                i_x += 1
            end
        end
    end
end

