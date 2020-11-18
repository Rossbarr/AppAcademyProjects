class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader(:pegs)

  def self.valid_pegs?(array)
    array.all? { |peg| Code::POSSIBLE_PEGS.key?(peg.upcase) }
  end

  def self.random(length)
    Code.new( Array.new(length) { arr << Code::POSSIBLE_PEGS.keys.sample } )
  end

  def self.from_string(string)
    Code.new(string.split(""))
  end

  def initialize(array)
    raise "Invalid pegs" if !Code.valid_pegs?(array)
    @pegs = array.map(&:upcase)
  end

  def [](index)
    self.pegs[index]
  end
  
  def length
    self.pegs.length
  end

  def num_exact_matches(guess)
    (0...guess.length).count { |i| guess[i] == @pegs[i] }
  end

  def num_near_matches(guess)
    count = 0
    guess.pegs.each_with_index do |peg, i|
      count += 1 if self.pegs.include?(peg) and peg != self.pegs[i]
    end
    count
  end

  def ==(guess)
    guess == self.pegs
  end
end
