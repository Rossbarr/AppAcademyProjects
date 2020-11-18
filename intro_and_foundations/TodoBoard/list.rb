require_relative 'item.rb'

class List
    attr_accessor(:label)
    
    def initialize(label)
        @label = label
        @items = []
    end

    def add_item(title, date = Time.now.strftime("%Y-%m-%d"), description = "")
        begin @items << Item.new(title, date, description)
            return true
        rescue
            return false
        end
    end

    def valid_index?(index)
        if @items[index]
            return true
        end
        return false
    end

# IN-LIST PRINT-COMMANDS

    def print
        puts "-".ljust(50, "-")
        puts "|" + @label.center(48) + "|"
        puts "-".ljust(50, "-")
        puts "| Idx | " + "Item".center(19) + " | " + "Date".center(10) + " | " + "Done?" + " |"
        puts "-".ljust(50, "-")
        @items.each_with_index do |item, index|
            puts "| " + index.to_s.rjust(3) + " | " + item.title.ljust(19) + " | " + item.date.ljust(10) + " | " + item.done.to_s.ljust(5) + " |"
        end
        puts "-".ljust(50, "-")
    end

    def print_item(index)
        puts "-".ljust(40, "-")
        puts @items[index].title.ljust(30) + @items[index].date.rjust(10)
        puts @items[index].description
        puts "Done?".ljust(30) + @items[index].done.to_s.rjust(10)
        puts "-".ljust(40, "-")
    end

    def priority
        self.print_item(0)
    end

# IN-LIST MOVEMENT-COMMANDS

    def swap(idx1, idx2)
        if valid_index?(idx1) and valid_index?(idx2)
            @items[idx1], @items[idx2] = @items[idx2], @items[idx1]
            return true
        end
        return false
    end

    def up(idx, amt = 1)
        return false if !valid_index?(idx)
            
        while amt > 0 and idx > 0
            swap(idx - 1, idx)
            amt -= 1
            idx -= 1
        end
        return true
    end

    def down(idx, amt = 1)
        return false if !valid_index?(idx)

        while amt > 0 and idx < (@items.length - 1)
            swap(idx + 1, idx)
            amt -= 1
            idx += 1
        end
        return true
    end

    def sort_by_date!
        @items.sort_by! { |item| item.date }
        return l.print
    end

    def remove_item(index)
        if self.valid_index?(index)
            @items.delete_at(index)
            return true
        end
        return false
    end

    def purge
        @items = @items.select { |item| !item.done}
        self.print
    end

    # ITEM-CHANGING COMMANDS

    def toggle_item(idx)
        @items[idx].toggle
    end
end
