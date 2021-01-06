def sluggish(array)
  array.each do |fish1|
    if array.all? { |fish2| fish1.length >= fish2.length }
      return fish1
    end
  end
end
