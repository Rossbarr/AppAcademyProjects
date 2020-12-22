require "rspec"
require "deck"

describe "Deck" do
    describe "#init" do
        it "creates a deck of 52 cards" do
            deck = Deck.new
            expect(deck.cards.length).to eq(52)
        end
    end

    describe "#shuffle!" do
        it "shuffles the deck of cards" do
            deck1 = Deck.new
            deck2 = Deck.new
            deck1.shuffle!
            expect(deck1.cards).to_not eq(deck2.cards)
        end
    end

    describe "#draw" do
        subject(:deck) { Deck.new }

        it "draws a card into the hand" do
            deck.draw
            expect(deck.cards.length).to eq(51)
        end
    end

    describe "#return(card)" do
        subject(:deck) { Deck.new }

        it "accepts a card and places it into it's array" do
            card = deck.draw
            deck.return(card)
            expect(deck.cards.length).to eq(52)
        end

        it "raises an error if the parameter is not a card" do
            card = 1
            expect { deck.return(card) }.to raise_error(ArgumentError)
        end

        it "raises an error if the card is already in the deck" do
            card = "KH"
            expect { deck.return(card) }.to raise_error(ArgumentError)
        end
    end
end