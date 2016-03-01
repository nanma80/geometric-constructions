class Circle < Entity
  attr_reader :center, :radius

  def initialize(center, params)
    super
    @center = center
    if params.is_a?(Point)
      point = params
      @radius = get_radius(center, point)
      definition[:is_centered_at] = [ center ]
      definition[:passes] = [ point ]
    else
      points = params
      @radius = get_radius(points[0], points[1])
      definition[:is_centered_at] = [ center ]
      definition[:radius_is_the_distance_between] = points
    end
  end

  def description
    "Center: (#{FLOAT_DISPLAY % center.x}, #{FLOAT_DISPLAY % center.y}). Radius: #{FLOAT_DISPLAY % radius}"
  end

  def ==(that)
    unless that.is_a?(Circle)
      raise "Comparing #{that.inspect} to a circle"
    end

    center == that.center && (radius - that.radius).abs < EPSILON
  end

  def intersection_with_line(line)
    line.intersection_with_circle(self)
  end

  def intersection_with_circle(that)
    x1 = center.x
    x2 = that.center.x
    y1 = center.y
    y2 = that.center.y
    r1 = radius
    r2 = that.radius

    a = 2 * (x2 - x1)
    b = 2 * (y2 - y1)
    c = r1 * r1 - x1 * x1 - y1 * y1 - r2 * r2 + x2 * x2 + y2 * y2 - a * x1 - b * y1

    delta = r1 * r1 * (a * a + b * b) - c * c

    if delta < - EPSILON
      return []
    elsif delta.abs < EPSILON
      tangent_x = a * c / (a * a + b * b) + x1
      tangent_y = b * c / (a * a + b * b) + y1
      tangent = Point.new([tangent_x, tangent_y])
      tangent.definition[:is_intersection_of] = [self, that]
      return [tangent]
    else
      sqrt_delta = Math.sqrt(delta)
      inter_x1 = (a * c + b * sqrt_delta) / (a * a + b * b) + x1
      inter_x2 = (a * c - b * sqrt_delta) / (a * a + b * b) + x1
      inter_y1 = (b * c - a * sqrt_delta) / (a * a + b * b) + y1
      inter_y2 = (b * c + a * sqrt_delta) / (a * a + b * b) + y1

      p1 = Point.new([inter_x1, inter_y1])
      p2 = Point.new([inter_x2, inter_y2])
      p1.definition[:is_intersection_of] = [self, that]
      p2.definition[:is_intersection_of] = [self, that]
      return [p1, p2]
    end
  end

  def get_radius(p1, p2)
    raise if p1 == p2
    dx = p1.x - p2.x
    dy = p1.y - p2.y

    Math.sqrt(dx * dx + dy * dy)
  end

  def find_same(layout)
    layout.circles.each do |circle|
      if self == circle
        return circle
      end
    end
    nil
  end

  def is_new?(layout)
    find_same(layout).nil?
  end
end
