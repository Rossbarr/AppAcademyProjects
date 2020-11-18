require_relative "room"

class Hotel
  def initialize(name_string, rooms_hash)
    @name = name_string
    @rooms = {}
    rooms_hash.each do |name, capacity|
        @rooms[name] = Room.new(capacity)
    end
  end

  def name
    @name.split(" ").map(&:capitalize).join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    rooms.has_key?(room_name)
  end

  def check_in(name, room_name)
    if self.room_exists?(room_name)
        if @rooms[room_name].add_occupant(name)
            puts "check in successful"
        else
            puts "sorry, room is full"
        end
    else
        puts "sorry, room does not exist"
    end

  end

  def has_vacancy?
    @rooms.values.any? { |room| !room.full? }
  end

  def list_rooms
    @rooms.each do |name, room|
        puts "#{name} : #{room.available_space}"
    end
  end
end
