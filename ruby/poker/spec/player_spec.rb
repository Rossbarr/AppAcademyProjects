require "rspec"
require "player"

describe "Player" do
    subject(:player) { Player.new }
    let(:hand) { Hand.new }

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
            expect(player.input).to receive(:gets).with("1 2 4")
        end
    end
end


