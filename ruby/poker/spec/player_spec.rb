require "rspec"
require "player"

describe "Player" do
    let(:hand) { Hand.new }
    let(:deck) { Deck.new }
    subject(:player) { Player.new(deck) }

    describe "#init" do
        it "creates a hand variable" do
            expect(player.hand).to be_a(Hand)
        end

        it "creates a pot variable" do
            expect(player.pot).to be_a(Integer)
        end
    end

    describe "#discard" do
        it "expects user input" do
            expect(player.discard).to receive(:gets).with("1 2 4")
        end
    end
end


