class Card
    RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
    SUITS = ["H", "D", "S", "C"]

    attr_reader(:value)
    
    def initialize(value)

        raise ArgumentError.new("Card value must be a string") if !value.is_a?(String)
        
        if !RANKS.include?(value[0]) or !SUITS.include?(value[1])
            raise ArgumentError.new("Invalid card value")
        end

        @value = value
    end

    def rank
        return @value[0]
    end

    def suit
        return @value[1]
    end
end