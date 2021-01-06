class Hand
    attr_reader :hand, :deck
    attr_writer :hand

    def initialize(deck)
        @deck = deck
        @hand = []
    end

    def draw
        if @hand.length < 5
            @hand << @deck.draw
        end

        if @hand.length > 1
            sort
        end
    end

     def return(i)
        deck.return(@hand[i])
        @hand.delete(@hand[i])
    end
 
    def value
        sort
        if is_flush
            if is_straight
                return 100000 * @hand[0].index
            else
                return 1000 + @hand[0].index + @hand[1].index + @hand[2].index + @hand[3].index + @hand[4].index
            end
        elsif is_straight
            return 500 + @hand[0].index
        elsif is_four_of_a_kind
            sort_four_of_a_kind
            return 40000 + @hand[0].index
        elsif is_full_house
            sort_full_house
            return 10000 + @hand[0].index + @hand[3].index
        elsif is_three_of_a_kind
            sort_three_of_a_kind
            return 150 + @hand[0].index
        elsif is_two_pair
            sort_two_pair
            return 100 + @hand[0].index + @hand[2].index
        elsif is_two_of_a_kind
            sort_two_of_a_kind
            return 50 + @hand[0].index
        else
            return @hand[0].index
        end
    end

    def size
        return @hand.length
    end

    def sort(p = 2)
        sorted = false
        while not sorted
            sorted = true
            @hand.each_with_index do |card, i|
                if i < @hand.length - 1 and card.index < @hand[i+1].index
                    @hand[i], @hand[i+1] = @hand[i+1], @hand[i]
                    sorted = false
                end
            end
        end
    end

    private
    
    def is_flush
        return @hand.all? { |card| card.suit == @hand[0].suit }
    end

    def is_straight
        @hand.each_with_index do |card, i|
            if i < 4
                if not (@hand[i].index == @hand[i + 1].index + 1)
                    return false
                end
            end
        end
        return true
    end

    def is_four_of_a_kind
        if @hand.length >= 4
            @hand.each_with_index do |card, i|
                counter = 1
                rank_counter = 1
                while i + counter < @hand.length
                    if @hand[i + counter].rank == card.rank
                        rank_counter += 1
                        if rank_counter == 4
                            return true
                        end
                    end
                    counter += 1
                end
            end
        end
        return false
    end

    def is_full_house
        three_of_a_kind = false
        three_of_a_kind_rank = nil
        if @hand.length == 5
            @hand.each_with_index do |card, i|
                counter = 1
                rank_counter = 1
                while i + counter < @hand.length 
                    if @hand[i + counter].rank == card.rank
                        rank_counter += 1
                        if rank_counter == 3
                            three_of_a_kind = true
                            three_of_a_kind_rank = card.rank
                        end
                    end
                    counter += 1
                end
            end
            @hand.each_with_index do |card, i|
                counter = 1
                if three_of_a_kind == true
                    while i + counter < @hand.length
                        if card.rank != three_of_a_kind_rank and @hand[i + counter].rank == card.rank
                            return true
                        end
                        counter += 1
                    end
                end
            end
        end
        return false
    end
   
    def is_three_of_a_kind
        if @hand.length >= 3
            @hand.each_with_index do |card, i|
                counter = 1
                rank_counter = 1
                while i + counter < @hand.length
                    if @hand[i + counter].rank == card.rank
                        rank_counter += 1
                        if rank_counter == 3
                                return true
                        end
                    end
                    counter += 1
                end
            end
        end
        return false
    end

    def is_two_pair
        pair_counter = 0
        if @hand.length >= 4
            @hand.each_with_index do |card, i|
                counter = 1
                while i + counter < @hand.length
                    if @hand[i + counter].rank == card.rank
                        pair_counter += 1
                        if pair_counter == 2
                            return true
                        end
                    end
                    counter += 1
                end
            end
        end
        return false
    end
 
    def is_two_of_a_kind
        if @hand.length >= 2
            @hand.each_with_index do |card, i|
                counter = 1
                while i + counter < @hand.length
                    if @hand[i + counter].rank == card.rank
                        return true
                    end
                    counter += 1
                end
            end
        end
        return false
    end

    def sort_four_of_a_kind
        if @hand[0].rank == @hand[1].rank and @hand[0].rank == @hand[2].rank
            rank = @hand[0].rank
        else
            rank = @hand[1].rank
        end
        @hand.each_with_index do |card, i|
            if card.rank != rank and i != 4
                @hand[i], @hand[4] = @hand[4], @hand[i]
            end
        end
    end

    def sort_full_house
        sort_three_of_a_kind
    end
    
    def sort_three_of_a_kind
        three_of_a_kind_rank = nil
        @hand.each_with_index do |card, i|
            if @hand[i + 1].rank == card.rank
                three_of_a_kind_rank = card.rank
                break
            end
        end
        three_of_a_kind_array = []
        rest_array = []
        @hand.each do |card|
            if card.rank == three_of_a_kind_rank
                three_of_a_kind_array << card
            else
                rest_array << card
            end
        end
        @hand = three_of_a_kind_array + rest_array
    end

    def sort_two_pair
        first_pair = []
        second_pair = []
        other_card = []
        if @hand[0].rank == @hand[1].rank
            first_pair = [@hand[0], @hand[1]]
        else
            other_card = [@hand[0]]
            first_pair = [@hand[1], @hand[2]]
            second_pair = [@hand[3], @hand[4]]
            @hand = first_pair + second_pair + other_card
            return
        end

        if @hand[2] == @hand[3]
            second_pair = [@hand[2], @hand[3]]
            other_card = [@hand[4]]
            @hand = first_pair + second_pair + other_card
            return
        else
            other_card = [@hand[2]]
            second_pair = [@hand[3], @hand[4]]
            @hand = first_pair + second_pair + other_card
            return
        end
    end

    def sort_two_of_a_kind
        pair_array = []
        rest_array = []
        @hand.each_with_index do |card, i|
            counter = 1
            while i + counter < @hand.length
                if @hand[i + counter].rank == card.rank
                    @hand[0], @hand[i] = @hand[i], @hand[0]
                    @hand[1], @hand[i + counter] = @hand[i + counter], @hand[1]
                end
                counter += 1
            end
        end
    end
end