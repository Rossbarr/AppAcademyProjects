class Player
    def get_move
        print "enter a position with coordinates separated with a space, like '4 7'\n"
        gets.chomp.split(" ").map(&:to_i)
    end
end
