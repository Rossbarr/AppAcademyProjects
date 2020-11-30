class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @seq = []
    @game_over = false
  end

  def play
    while @game_over == false
      take_turn
    end
    if @game_over
      game_over_message
      reset_game
    end
  end

  def take_turn
    system("clear")
    show_sequence
    if @seq != require_sequence
      @game_over = true
    else
      @sequence_length += 1
      round_success_message
    end
  end

  def show_sequence
    color = add_random_color
    puts(color)
  end

  def require_sequence
    gets.chomp.split(" ")
  end

  def add_random_color
    color = COLORS.sample()
    @seq << color
    return color
  end

  def round_success_message
    puts "Success!"
  end

  def game_over_message
    puts "Failure!"
  end

  def reset_game
    @sequence_length = 1
    @seq = []
    @game_over = false
  end
end
