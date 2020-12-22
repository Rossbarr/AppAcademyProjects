require "rspec"
require "hand"
require "deck"

describe "Hand" do
    let(:deck) { Deck.new }
    subject(:hand) { Hand.new(deck) }

    describe "#init" do
        it "creates an empty array" do
            expect(hand.hand).to eq([])
        end

        it "contains a reference to the deck" do
            expect(hand.deck).to be(deck)
        end
    end

    describe "#draw" do
        it "draws a card from the deck" do
            hand.draw
            expect(hand.hand.length).to eq(1)
        end

        it "will not draw past 5 times" do
            5.times do
                hand.draw
            end
            expect(hand.hand.length).to_not eq(6)   
        end
    end

    describe "#return(index)" do
        it "returns a card from hand at index to deck" do
            3.times do
                hand.draw
            end
            hand.return(2)
            expect(hand.hand.length).to eq(2)
        end
    end

    describe "#value" do
        it "returns the value of its hand" do
            expect(2).to eq(3)
        end
    end
end