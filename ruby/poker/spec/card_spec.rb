require "rspec"
require "card"

describe "Card" do
    describe "#init" do
        it "expects a string" do
            expect { Card.new("hello") }.to raise_error(ArgumentError)
        end

        it "expects the suit to be valid" do
            expect { Card.new("KJ") }.to raise_error(ArgumentError)
        end

        it "expects the rank to be valid" do
            expect { Card.new("IS") }.to raise_error(ArgumentError)
        end
    end

    describe "#value" do
        it "returns the string" do
            card = Card.new("KH")
            expect(card.value).to eq("KH")
        end
    end

    describe "#rank" do
        it "returns the card's rank" do
            card = Card.new("KH")
            expect(card.rank).to eq("K")
        end
    end

    describe "#suit" do
        it "returns the card's suit" do
            card = Card.new("KH")
            expect(card.suit).to eq("H")
        end
    end
end