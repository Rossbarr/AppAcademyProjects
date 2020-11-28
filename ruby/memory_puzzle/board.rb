require_relative "card.rb"

class Board
	def initialize(n = 4)
	  raise "need even n" if n % 2 == 1
	  raise "n must be < 27" if n > 26
      self.create_grid(n)
      self.populate(n)
      self.render
      return
      print 'hello'
	end

    def populate(n)
      available_slots = self.get_available_slots
      self.fill_available_slots(available_slots)
    end

    def render
      sleep(2)
      system("clear")
      @grid.each do |row|
        row.each do |ele|
          if ele.class == Card
            if ele.face_up
              print ele.value + " "
            else
              print "  "
            end
          else
            print ele.to_s + " "
          end
        end
        puts
      end
	end

	def won?
      @grid.each do |row|
        row.each do |card|
          if card.class == Card
            unless card.face_up
              return false
            end
          end
        end
      end
      return true
	end

	def reveal(guessed_pos)
      x, y = guessed_pos
      card = @grid[x][y]
      unless card.face_up
        card.reveal
        return card
      end
	end

    private

    def create_grid(n)
      @grid = Array.new(n+1) { Array.new(n+1, "fill") }
	  @grid.each_with_index do |row, i|
	    row.each_with_index do |col, j|
		  if i == 0
		    if j == 0
			  @grid[i][j] = " "
		    else
			  @grid[i][j] = j
		    end
		  elsif j == 0
		    @grid[i][j] = i
		  end
	    end
	  end
    end

    def get_available_slots
      available_slots = Array.new
      @grid.each_with_index do |row, i|
        row.each_with_index do |ele, j|
          if ele == "fill"
            available_slots << [i, j]
          end
        end
      end
      return available_slots
    end

    def fill_available_slots(available_slots)
      alpha = ("A".."Z").to_a
      i = 0
      while available_slots.length > 0
        2.times do 
          card = Card.new(alpha[i])
          x, y = available_slots.sample
          @grid[x][y] = card
          available_slots.delete([x, y])
        end
        i += 1
      end
    end
end
