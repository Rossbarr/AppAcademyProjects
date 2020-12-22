require_relative "card"

class Deck
    RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
    SUITS = ["H", "D", "S", "C"]

    attr_reader :cards

    def initialize
        create_deck
    end

    def shuffle!
        @cards.shuffle!
    end

    def draw
        return @cards.pop
    end

    def return(card)
        puts(card)
        raise ArgumentError.new("Deck can only accept cards") if !card.is_a?(Card)
        if @cards.include?(card)
            raise ArgumentError.new("Deck already contains card")
        end

        @cards << card
    end

    private
    
    def create_deck
        @cards = []
        RANKS.each do |rank|
            SUITS.each do |suit|
                @cards << Card.new(rank + suit)
            end
        end
    end
end