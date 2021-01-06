require_relative "hand"

class Player
    attr_reader :hand, :pot

    def initialize(deck, pot = 1000)
        @hand = Hand.new(deck)
        @pot = pot
    end

    def discard
        return gets.chomp.split(" ").each { |c| c.to_i }
    end

    def input
        gets.chomp
    end
end