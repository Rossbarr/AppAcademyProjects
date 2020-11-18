class ComputerPlayer
  def initialize(n)
    @known_cards = Hash.new
    @matched_cards = Array.new
    possible_locations = Array.new
    (1..n).each do |i|
      (1..n).each do |j|
        possible_locations << [i, j]
      end
    end
    @possible_locations = possible_locations
  end

  def prompt(previous_card = nil)
    puts "choose a card to reveal in the form of 'row col' (e.g. '1 2') : "
    if previous_card
      card = self.find_other_card(previous_card)
      if card
        p "found a similar card"
        p "choosing #{card}"
        return card
      end
    else
      card = self.search_revealed_cards()
      if card
        p "found two-like cards, attempting to choose them"
        p "choosing #{card}"
        return card
      end
    end

    while true
        card = @possible_locations.sample
        if card != previous_card  
          p "choosing #{card}"
          return card
        end
    end
  end

  def search_revealed_cards()
    @known_cards.each do |key, value|
      @known_cards.each do |k, v|
        if v == value and k != key and !@possible_locations.include?(key)
          return key
        end
      end
    end
    return false
  end

  def find_other_card(previous_card)
    value = @known_cards[previous_card]
    @known_cards.each do |key, v|
      if v == value and key != previous_card
        return key
      end
    end
    return false
  end

  def receive_revealed_card(pos, value)
    @known_cards[pos] = value
    @possible_locations.delete(pos)
  end

  def receive_match(pos1, pos2)
    @matched_cards << [pos1, pos2]
    @possible_locations.delete(pos1)
    @possible_locations.delete(pos2)
    @known_cards.delete(pos1)
    @known_cards.delete(pos2)
  end
end

