class Circle
  attr_reader :center, :radius

  def initialize(center, point)
    @center = center
    @radius = get_radius(point)
  end

  def ==(that)
    unless that.is_a?(Circle)
      raise "Comparing #{that.inspect} to a circle"
    end

    center == that.center && (radius - that.radius).abs < EPSILON
  end

  def get_radius(point)
    raise if point == center
    dx = center.x - point.x
    dy = center.y - point.y

    Math.sqrt(dx * dx + dy * dy)
  end
end
