class Point
  attr_reader :coordinates, :id

  def initialize(coordinates)
    @coordinates = coordinates.map{|c| c * 1.0}
    @id = nil
  end

  def x
    coordinates[0]
  end

  def y
    coordinates[1]
  end

  def equals?(that)
    unless that.is_a?(Point)
      raise "Comparing #{that.inspect} to a point"
    end

    coordinates.each_with_index do |c, index|
      if (c - that.coordinates[index]).abs > GeometricConstructions::EPSILON
        return false
      end
    end

    true
  end

  def id=(new_id)
    if @id.nil?
      @id = new_id
    else
      raise 'id cannot be assigned twice'
    end
  end
end