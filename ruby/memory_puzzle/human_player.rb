class HumanPlayer
  def prompt(previous_guess = nil)
    puts "choose a card to reveal in the form of 'row col' (e.g. '1 2') : "
    guess = gets.chomp.split(" ").map(&:to_i)
    return guess
  end

  def receive_revealed_card(pos, value)
  end

  def receive_match(pos1, pos2)
  end
end

