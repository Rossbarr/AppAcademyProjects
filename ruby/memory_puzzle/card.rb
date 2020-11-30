class Card
	attr_reader(:value, :face_up)
	
    def initialize(value, face_up = false)
        @value = value
        @face_up = face_up
    end

	def reveal
		@face_up = true
	end

	def hide
		@face_up = false
	end

	def to_s
		return @value.to_s
	end

	def ==(card)
		return (@value == card.value)
	end
end
