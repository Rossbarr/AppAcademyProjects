class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new(0) }
    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, i|
      if i != 6 and i != 13
        cup.push(:stone, :stone, :stone, :stone)
      end
    end
  end

  def valid_move?(start_pos)
    raise ArgumentError.new("Invalid starting cup") if start_pos >= 13
    raise ArgumentError.new("Starting cup is empty") if @cups[start_pos].length == 0
    true
  end

  def make_move(start_pos, current_player_name)
    @player2 ||= current_player_name if @player1 != nil
    @player1 ||= current_player_name
    if current_player_name == @player1
      not_my_cup = 13
    else
      not_my_cup = 6
    end

    if valid_move?(start_pos)
      stones = @cups[start_pos]
      @cups[start_pos] = []
      counter = 0
      while stones.length > 0
        counter += 1
        if (start_pos + counter) % 14 != not_my_cup
          @cups[(start_pos + counter) % 14].push(stones.pop)
        end
      end
    end

    self.render
    self.next_turn((start_pos + counter) % 14)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if ending_cup_idx == 6 or ending_cup_idx == 13
      return :prompt
    elsif @cups[ending_cup_idx].count == 1
      return :switch
    else
      return ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all? { |cup| cup.empty? } or @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    if @cups[6].count > @cups[13].count
      return "Erica"
    elsif @cups[13].count > @cups[6].count
      return "James"
    else
      return :draw
    end
  end
end
