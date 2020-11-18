class Flight
    attr_reader(:passengers)

    def initialize(str, capacity)
        @flight_number = str
        @capacity = capacity
        @passengers = Array.new
    end

    def full?
        @passengers.length >= @capacity
    end

    def board_passenger(passenger)
        if !self.full? and passenger.has_flight?(@flight_number)
            @passengers << passenger
        end
    end

    def list_passengers
        @passengers.map do |ele|
            ele.name
        end
    end

    def [](num)
        @passengers[num]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end
