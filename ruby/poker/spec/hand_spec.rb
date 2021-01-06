require "rspec"
require "hand"
require "deck"

RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

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
        context "when the hand is a royal flush" do
            it "returns a high value" do
                card1 = Card.new("AH")
                card2 = Card.new("KH")
                card3 = Card.new("QH")
                card4 = Card.new("JH")
                card5 = Card.new("TH")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(100000*12)
            end
        end

        context "when the hand is a straight flush" do
            it "returns a 100000s value" do
                card1 = Card.new("6H")
                card2 = Card.new("5H")
                card3 = Card.new("4H")
                card4 = Card.new("3H")
                card5 = Card.new("2H")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(100000*4)
            end
        end
        
        context "when the hand is a four-of-a-kind" do
            it "returns a 40000s value" do
                card1 = Card.new("7H")
                card2 = Card.new("7S")
                card3 = Card.new("7D")
                card4 = Card.new("7C")
                card5 = Card.new("TH")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(40000+5)
            end
        end

        context "when the hand is a full house" do
            it "returns a 10000s value" do
                card1 = Card.new("JH")
                card2 = Card.new("JS")
                card3 = Card.new("JD")
                card4 = Card.new("8H")
                card5 = Card.new("8D")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(10000+9+6)
            end
        end

        context "when the hand is a flush" do
            it "returns a 1000s value" do
                card1 = Card.new("AH")
                card2 = Card.new("QH")
                card3 = Card.new("TH")
                card4 = Card.new("6H")
                card5 = Card.new("2H")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(1000+12+10+8+4+0)
            end
        end

        context "when the hand is a straight" do
            it "returns a 500s value" do
                card1 = Card.new("TH")
                card2 = Card.new("9C")
                card3 = Card.new("8D")
                card4 = Card.new("7S")
                card5 = Card.new("6H")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(500+8)
            end
        end

        context "when the hand is a three-of-a-kind" do
            it "returns a 150s value" do
                card1 = Card.new("AH")
                card2 = Card.new("AC")
                card3 = Card.new("AS")
                card4 = Card.new("TC")
                card5 = Card.new("6D")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(150+12)
            end
        end

        context "when the hand is a two pair" do
            it "returns a 100s value" do
                card1 = Card.new("7H")
                card2 = Card.new("7S")
                card3 = Card.new("4C")
                card4 = Card.new("4H")
                card5 = Card.new("TH")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(100+5+2)
            end
        end

        context "when the hand is a one pair" do
            it "returns a 50s value" do
                card1 = Card.new("9H")
                card2 = Card.new("9C")
                card3 = Card.new("4D")
                card4 = Card.new("3H")
                card5 = Card.new("2S")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(50+7)
            end
        end

        context "when the hand is a high card" do
            it "returns a 1s value" do
                card1 = Card.new("7H")
                card2 = Card.new("5C")
                card3 = Card.new("4H")
                card4 = Card.new("3H")
                card5 = Card.new("2H")
                hand.hand = [card1, card2, card3, card4, card5]
                expect(hand.value).to be_a(Integer)
                expect(hand.value).to eq(5)
            end
        end
    end

    describe "#sort" do
        it "sorts the hand from highest value card to lowest value card" do
            card1 = Card.new("7H")
            card2 = Card.new("5C")
            card3 = Card.new("4H")
            card4 = Card.new("3H")
            card5 = Card.new("2H")
            hand.hand = [card2, card4, card5, card1, card3]
            hand.sort
            RANKS.index(hand.hand[4].rank) < RANKS.index(hand.hand[0].rank)
        end
    end

    describe "#size" do
        it "returns the number of cards" do
            expect(hand.size).to eq(hand.hand.length)
        end
    end
end