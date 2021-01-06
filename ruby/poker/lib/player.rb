require_relative "hand"

class Player
    attr_reader :hand, :pot

    def initialize(deck, pot = 1000)
        @hand = Hand.new(deck)
        @pot = pot
    end

    def discard
        cards = gets.chomp
    end
end