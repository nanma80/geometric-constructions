class Point < Entity
  attr_reader :coordinates

  def initialize(coordinates)
    super
    @coordinates = coordinates.map{|c| c * 1.0}
  end

  def description
    "Coordinates: (#{x}, #{y})"
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
      if (c - that.coordinates[index]) ** 2 > EPSILON
        return false
      end
    end

    true
  end

  def on_line?(line)
    (x * Math.cos(line.norm_direction) + y * Math.sin(line.norm_direction) - line.origin_distance).abs < EPSILON
  end

  def find_same(layout)
    layout.points.each do |point|
      if self == point
        return point
      end
    end
    nil
  end

  def is_new?(layout)
    find_same(layout).nil?
  end
end