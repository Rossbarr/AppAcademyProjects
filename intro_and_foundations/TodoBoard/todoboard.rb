require_relative "list.rb"

class TodoBoard
    def initialize
        @lists = Hash.new { |h,k| h[k] = List.new(k) }
    end

    def get_command
        print "\nEnter a command: "
        cmd, list_label, *args = gets.chomp.downcase.split(" ")

        case cmd

        when "mklist"
            @lists[list_label.to_s] = List.new(list_label.to_s)
            
        when "ls"
            puts @lists

        when "showall"
            @lists.each do |label, list|
                list.print
            end

        when "mktodo"
            @lists[list_label].add_item(*args)
            return true

        when "up"
            @lists[list_label].up(*args)
            return true

        when "down"
            @lists[list_label].down(*args)
            return true
        
        when "swap"
            @lists[list_label].swap(*args)
            return true
        
        when "sort"
            @lists[list_label].sort_by_date!
            return true
        
        when "priority"
            @lists[list_label].priority
            return true
        
        when "print"
            if args != []
                @lists[list_label].print_item(args[0].to_i)
                return true
            else
                @lists[list_label].print
                return true
            end
        
        when "toggle"
            @lists[list_label].toggle_item(args[0].to_i)
            return true

        when "rm"
            return @lists[list_label].remove_item(args[0].to_i)

        when "purge"
            @lists[list_label].purge
            return true
        
        when "quit", "exit"
            return false
        
        else
            puts "invalid command, please try again"
            return true
        end
    end

    def run
        while self.get_command
        end
    end

end

board = TodoBoard.new
board.run