class Tile
  attr_reader(:value, :given)

  def initialize(value = 0, given = false)
    @value = value
    @given = given
  end

  def value=(new_value)
    if !@given
      @value = new_value
      return true
    end
    return false
  end
end

