require './geometric-constructions'

bottom_right_point = Point.new([0, 0]).with_name('bottom right point')
bottom_left_point = Point.new([-4, 0]).with_name('bottom left point')
bottom_line = LineSegment.new([bottom_left_point, bottom_right_point]).with_name('bottom line')

random_point_outside = Point.new([-1.31441, 0.8351]).with_name('random point outside')
random_point_online = Point.new([-1.6813, 0]).with_name('random point online')


top_point = Point.new([0, 3]).with_name('top point')
vertical_line = Line.new([top_point, bottom_right_point]).with_name 'vertical line'
hypotenuse_line = Line.new([top_point, bottom_left_point]).with_name('hypotenuse point')

# initial_layout = Layout.new([bottom_left_point, bottom_right_point, random_point_outside, random_point_online], [bottom_line], [])

initial_layout = Layout.new([bottom_left_point, bottom_right_point], [bottom_line], [])

targets = [hypotenuse_line, top_point, vertical_line]

# steps = [:perp, :perp_bis, :perp_bis, :circle]
steps = [:line, :circle, :circle, :circle, :line, :line, :line]
filters = {
	5 => [vertical_line]
}

task = Task.new(initial_layout, targets, steps, filters)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 17 points; 5 lines; 3 circles
# Point #0 is the bottom left point. Coordinates: (-4.00000, 0.00000)
# Point #1 is the bottom right point. Coordinates: (0.00000, 0.00000)
# Line #2 passes Point #1, Point #0. Norm direction: 90.00000. Distance to origin: 0.00000
# Circle #3 is centered at Point #1 and passes Point #0. Center: (0.00000, 0.00000). Radius: 4.00000
# Point #4 is intersection of Line #2, Circle #3. Coordinates: (4.00000, -0.00000)
# Circle #5 is centered at Point #0 and passes Point #4. Center: (-4.00000, 0.00000). Radius: 8.00000
# Point #6 is intersection of Line #2, Circle #5. Coordinates: (-12.00000, 0.00000)
# Circle #7 is centered at Point #4 and passes Point #0. Center: (4.00000, -0.00000). Radius: 8.00000
# Point #8 is intersection of Circle #7, Circle #5. Coordinates: (0.00000, 6.92820)
# Point #9 is intersection of Circle #7, Circle #5. Coordinates: (0.00000, -6.92820)
# Line #10 passes Point #8, Point #9. Norm direction: 0.00000. Distance to origin: 0.00000
# Point #11 is intersection of Line #10, Circle #3. Coordinates: (0.00000, 4.00000)
# Line #12 passes Point #6, Point #11. Norm direction: 108.43495. Distance to origin: 3.79473
# Point #13 is intersection of Line #12, Circle #5. Coordinates: (2.40000, 4.80000)
# Line #14 passes Point #0, Point #13. Norm direction: 126.86990. Distance to origin: 2.40000
# Line #14 is a target, the hypotenuse point
# Point #15 is intersection of Line #14, Line #10. Coordinates: (0.00000, 3.00000)
# Point #15 is a target, the top point
# Line #16 passes Point #8, Point #9. Norm direction: 0.00000. Distance to origin: 0.00000
# Line #16 is a target, the vertical line
