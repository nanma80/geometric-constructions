class Point < Entity
  attr_reader :coordinates

  def initialize(coordinates)
    super
    @coordinates = coordinates.map{|c| c * 1.0}
  end

  def x
    coordinates[0]
  end

  def y
    coordinates[1]
  end

  def ==(that)
    unless that.is_a?(Point)
      raise "Comparing #{that.inspect} to a point"
    end

    coordinates.each_with_index do |c, index|
      if (c - that.coordinates[index]).abs > EPSILON
        return false
      end
    end

    true
  end
end