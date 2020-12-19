class Array
    def two_sum
        pairs = []
        self.each_with_index do |num1, i|
            self.each_with_index do |num2, j|
                if i < j and num1 + num2 == 0
                    pairs << [i, j]
                end
            end
        end
        return pairs
    end
end

def my_transpose(array)
    transposed = Array.new(array[0].length) { Array.new(0, array.length) }
    array.each_with_index do |row, i|
        row.each_with_index do |num, j|
            transposed[j][i] = num
        end
    end
    return transposed
end