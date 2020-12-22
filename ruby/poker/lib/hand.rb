class Hand
    attr_reader :hand, :deck
    def initialize(deck)
        @deck = deck
        @hand = []
    end

    def draw
        if @hand.length < 5
            @hand << @deck.draw
        end
    end
    
    def return(i)
        deck.return(@hand[i])
        @hand.delete(@hand[i])
    end
end