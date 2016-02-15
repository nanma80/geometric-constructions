class LineSegment < Line
  def initialize(params)
    super
    if params.length != 2
      raise "Line Segment can only be defined by two points. Unkown expected params #{params}"
    end
    
    definition.delete(:passes)
    definition[:connects] = params
  end

  def ==(that)
    points_matching = (points[0] == that.points[0] && points[1] == that.points[1])
    points_swap_matching = (points[0] == that.points[1] && points[1] == that.points[0])
    super && (points_matching || points_swap_matching)
  end

  def contains?(point)
    x_in_range = ((point.x - points[0].x) * (point.x - points[1].x) <= EPSILON )
    y_in_range = ((point.y - points[0].y) * (point.y - points[1].y) <= EPSILON )
    super && x_in_range && y_in_range
  end

  def intersection_with_circle(circle)
    super.select {|point| contains?(point)}
  end

  def intersection_with_line(that)
    if colinear_with?(that)
      return []
    end

    candidates = super.select {|point| contains?(point)}

    if that.is_a?(LineSegment)
      candidates = candidates.select{|point| that.contains?(point)}
    end

    candidates
  end
end