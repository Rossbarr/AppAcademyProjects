# Write a method, swapper(arr, idx_1, idx_2), that accepts an array and two indices as args.
# The method should swap the elements at the given indices and return the array.
# The method should modify the existing array and not create a new array.

# def swapper(arr, idx_1, idx_2)
#     arr[idx_1], arr[idx_2] = arr[idx_2], arr[idx_1]
#     arr
# end


# p swapper(["a", "b", "c", "d"], 0, 2)               # => ["c", "b", "a", "d"]
# p swapper(["a", "b", "c", "d"], 3, 1)               # => ["a", "d", "c", "b"]
# p swapper(["canal", "broadway", "madison"], 1, 0)   # => ["broadway", "canal", "madison"]

arr_1 = [1,2]
arr_2 = arr_1
puts arr_1.object_id == arr_2.object_id

arr_2 << 3

puts arr_1
puts arr_2
puts arr_1.object_id == arr_2.object_id
