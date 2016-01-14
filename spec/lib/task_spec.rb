require 'spec_helper'

describe Task do
  it 'should drop perpendicular' do
    point_top = Point.new([0, 1]).with_name('top point')
    point_left = Point.new([-1.3, 0]).with_name('left point')
    point_right = Point.new([1.763, 0]).with_name('right point')
    horizontal_line = Line.new([point_left, point_right]).with_name('horizontal line')
    vertical_line = Line.new([point_top, Point.new([0, 2])]).with_name('vertical line')

    initial_layout = Layout.new([point_top, point_left, point_right], [horizontal_line], [])
    targets = [vertical_line]
    filters = {2 => [Point.new([0, -1])]}

    task = Task.new(initial_layout, targets, [:circle, :circle, :line], filters)

    solution_layout = task.solve

    expect(solution_layout).not_to be_nil
  end

  it 'should construct circumscribed circle' do
    ax = 0.0
    ay = -1
    bx = 0.0
    by = 1.3
    cx = 2.5
    cy = 0.0

    p1 = Point.new([ax, ay])
    p2 = Point.new([bx, by])
    p3 = Point.new([cx, cy])

    d = 2 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
    center_x = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) + (cx * cx + cy * cy)* (ay - by))/d
    center_y = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) + (cx * cx + cy * cy)* (bx - ax))/d
    center = Point.new([center_x, center_y])

    targets = [Circle.new(center, p3)]

    initial_layout = Layout.new([p1, p2, p3], [], [])

    task = Task.new(initial_layout, targets, [:perp_bis, :perp_bis, :circle])
    solution_layout = task.solve

    expect(solution_layout).not_to be_nil
  end

  it 'should construct geometric mean' do
    short = 1.0
    long = 2.23
    geo_mean = Math.sqrt(short * long)
    center_point = Point.new([0, 0])
    left_point = Point.new([- short, 0])
    right_point = Point.new([long, 0])
    horizontal_line = Line.new([center_point, left_point])

    theta = 34 * Math::PI / 180
    up_point = Point.new([geo_mean * Math.cos(theta), geo_mean * Math.sin(theta)])
    line2 = Line.new([center_point, up_point])

    initial_layout = Layout.new([center_point, left_point, right_point], [horizontal_line, line2], [])
    targets = [up_point]

    steps = [:perp_bis, :perp, :circle]

    task = Task.new(initial_layout, targets, steps)

    solution_layout = task.solve

    expect(solution_layout).not_to be_nil
  end

  it 'should construct parallelogram' do
    bottom_left = Point.new([0, 0])
    top_left = Point.new([1, 2])
    bottom_right = Point.new([3, 1])
    targets = [Point.new([4, 3])]

    initial_layout = Layout.new([bottom_left, bottom_right, top_left], [], [])

    steps = [:line, :line, :parallel, :parallel]

    task = Task.new(initial_layout, targets, steps)

    solution_layout = task.solve

    expect(solution_layout).not_to be_nil
  end

  it 'should translate a line segment' do
    left_bottom = Point.new([0, 0])
    left_top = Point.new([1, 2])

    right_bottom = Point.new([3, 1])
    right_top = Point.new([4, 3])

    left_line = Line.new([left_top, left_bottom])
    right_line = Line.new([right_top, right_bottom])

    initial_layout = Layout.new([left_bottom, left_top, right_bottom], [left_line], [])
    targets = [right_line, right_top]

    steps = [:parallel, :compass]

    task = Task.new(initial_layout, targets, steps)

    solution_layout = task.solve
    expect(solution_layout).not_to be_nil
  end
end
