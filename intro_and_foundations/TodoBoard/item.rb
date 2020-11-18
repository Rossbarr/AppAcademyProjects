class Item
    attr_accessor(:title, :date, :description)
    attr_reader(:done)

    def self.valid_date?(date)
        return false if date.length < 8

        arr = date.split("-")
        if 0 > arr[1].to_i or arr[1].to_i > 13 or 0 > arr[2].to_i or arr[2].to_i > 31
            return false
        end
        return true
    end

    def initialize(title, date, description, done = false)
        raise "invalid date format (use YYYY-MM-DD)" unless Item.valid_date?(date)
        @title = title
        @date = date
        @description = description
        @done = done
    end

    def toggle
        @done = !@done
    end
end