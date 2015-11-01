class Line < Entity
  attr_reader :normal_form

  def initialize(points)
    super
    @points = points
    @normal_form = get_normal_form(points)
    definition[:passing] = points
  end

  def origin_distance
    normal_form[1]
  end

  def norm_direction
    normal_form[0]
  end

  def ==(that)
    unless that.is_a?(Line)
      raise "Comparing #{that.inspect} to a line"
    end

    Point.new(normal_form) == Point.new(that.normal_form)
  end

  def intersection_with_circle(circle)
    a = Math.cos(norm_direction)
    b = Math.sin(norm_direction)
    c = origin_distance - a * circle.center.x - b * circle.center.y
    r = circle.radius
    delta = r * r * (a * a + b * b) - c * c

    if delta < - EPSILON
      return []
    elsif delta.abs < EPSILON
      tangent_x = a * c / (a * a + b * b) + circle.center.x
      tangent_y = b * c / (a * a + b * b) + circle.center.y
      tangent = Point.new([tangent_x, tangent_y])
      tangent.definition[:intersection] = [self, circle]
      return [tangent]
    else
      sqrt_delta = Math.sqrt(delta)
      x1 = (a * c + b * sqrt_delta) / (a * a + b * b) + circle.center.x
      x2 = (a * c - b * sqrt_delta) / (a * a + b * b) + circle.center.x
      y1 = (b * c - a * sqrt_delta) / (a * a + b * b) + circle.center.y
      y2 = (b * c + a * sqrt_delta) / (a * a + b * b) + circle.center.y

      p1 = Point.new([x1, y1])
      p2 = Point.new([x2, y2])
      p1.definition[:intersection] = [self, circle]
      p2.definition[:intersection] = [self, circle]
      return [p1, p2]
    end
  end

  def intersection_with_line(that)
    if self == that
      raise 'Cannot find intersection with the same line'
    end

    p1 = origin_distance
    p2 = that.origin_distance
    a1 = norm_direction
    a2 = that.norm_direction
    a12 = a1 - a2

    parallel_intersection = []

    if Math.sin(a12).abs < EPSILON
      return parallel_intersection
    end

    inter_x = (p2 * Math.sin(a1) - p1 * Math.sin(a2))/Math.sin(a12)
    inter_y = (p2 * Math.cos(a1) - p1 * Math.cos(a2))/Math.sin(- a12)

    intersection = Point.new([inter_x, inter_y])
    intersection.definition[:intersection] = [self, that]
    [intersection]
  end

  def get_normal_form(points)
    p1 = points.first
    p2 = points.last

    raise if p1 == p2

    x1 = p1.x
    x2 = p2.x
    y1 = p1.y
    y2 = p2.y

    a = y2 - y1
    b = x1 - x2

    c = a * x1 + b * y1

    if (c.abs < EPSILON)
      p = 0.0
      if (a.abs < EPSILON)
        divisor = b / b.abs / Math.sqrt(a * a + b * b)
      else
        divisor = a / a.abs / Math.sqrt(a * a + b * b)
      end
    else
      divisor = c / c.abs / Math.sqrt(a * a + b * b)
      p = c * divisor
    end

    cos = a * divisor
    sin = b * divisor
    
    alpha = Math.acos(cos)
    if sin < 0
      alpha = 2 * Math::PI - alpha
    end

    [alpha, p]
  end

  def find_same(layout)
    layout.lines.each do |line|
      if self == line
        return line
      end
    end
    nil
  end

  def is_new?(layout)
    find_same(layout).nil?
  end
end
