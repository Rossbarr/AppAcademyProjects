require "rspec"
require "tdd"

describe Array do
    describe "#uniq" do
        it "removes duplicates in the array" do
            expect([1, 2, 2, 3, 3, 2].uniq).to eq([1, 2, 3])
        end
    end

    describe "#two_sum" do
        it "returns pairs of indices which sum to zero" do
            expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
        end
    end
end

describe "my_transpose" do
    it "transposes a square matrix" do
        expect(my_transpose([[0, 1, 2], [3, 4, 5], [6, 7, 8]])).to eq([[0, 3, 6], [1, 4, 7], [2, 5, 8]])
    end
end