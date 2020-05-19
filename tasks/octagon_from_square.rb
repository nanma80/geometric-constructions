require './geometric-constructions'

bottom_left_point = Point.new([-1, -1]).with_name('bottom left point')
top_left_point = Point.new([-1, 1]).with_name('top left point')
bottom_right_point = Point.new([1, -1]).with_name('bottom right point')
top_right_point = Point.new([1, 1]).with_name('top right point')

left_line = LineSegment.new([bottom_left_point, top_left_point]).with_name('left line')
right_line = LineSegment.new([bottom_right_point, top_right_point]).with_name('right line')
top_line = LineSegment.new([top_right_point, top_left_point]).with_name('top line')
bottom_line = LineSegment.new([bottom_left_point, bottom_right_point]).with_name('bottom line')

theta = 22.5 * Math::PI / 180
target_point1 = Point.new([1, Math.tan(theta)]).with_name('target point1')
target_point2 = Point.new([Math.tan(theta), 1]).with_name('target point2')
target_line = Line.new([target_point1, target_point2]).with_name('target line')

initial_layout = Layout.new([bottom_left_point, bottom_right_point, top_left_point, top_right_point], [left_line, right_line, top_line, bottom_line], [])
targets = [target_line]

steps = [:perp_bis, :perp_bis, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)
