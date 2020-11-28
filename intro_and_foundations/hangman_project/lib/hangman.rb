class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length) { |i| "_" }
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end
  
  def secret_word
    @secret_word
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    self.attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index do |ele, i|
      if ele == char
        indices << i
      end
    end

    if indices.length == 0
      @remaining_incorrect_guesses -= 1
    end
    
    indices
  end

  def fill_indices(char, indices)
    indices.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    if !already_attempted?(char)
      fill_indices(char, get_matching_indices(char))
      @attempted_chars << char
      return true
    else
      puts "that has already been attempted"
      return false
    end
  end

  def ask_user_for_guess
    print "Enter a char:\n"
    try_guess(gets.chomp)
  end

  def win?
    if !@guess_word.include?("_")
      puts "WIN"
      return true
    end
    return false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    return false
  end

  def game_over?
    if win? or lose?
      puts @secret_word
      return true
    end
    return false
  end
end
