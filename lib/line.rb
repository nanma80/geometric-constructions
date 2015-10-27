class Line
  attr_reader :origin_distance, :norm_direction, :normal_form

  def initialize(points)
    @points = points
    @normal_form = normal_form(points)
  end

  def normal_form(points)
    p1 = points.first
    p2 = points.last

    # TODO: compute the normal form

  end
end