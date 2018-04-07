# 12.6 Equilateral triangle by centroid and two points

require './geometric-constructions'

origin = Point.new([0, 0])
point_top_theta = Math::PI / 2
point_bottom_left_theta = Math::PI / 2 + 2 * Math::PI / 3
point_bottom_right_theta = Math::PI / 2 - 2 * Math::PI / 3

point_top = Point.new([Math.cos(point_top_theta), Math.sin(point_top_theta)])
point_bottom_left = Point.new([Math.cos(point_bottom_left_theta), Math.sin(point_bottom_left_theta)])
point_bottom_right = Point.new([Math.cos(point_bottom_right_theta), Math.sin(point_bottom_right_theta)])

p point_top.coordinates
p point_bottom_left.coordinates
p point_bottom_right.coordinates

left_side = Line.new([point_top, point_bottom_left])
right_side = Line.new([point_top, point_bottom_right])

random_line = Line.new([Point.new([-1.14, 0]), Point.new([0, -0.342])])
given_point_left = random_line.intersection_with_line(left_side).first
given_point_right = random_line.intersection_with_line(right_side).first

p given_point_left.coordinates
p given_point_right.coordinates


initial_layout = Layout.new([origin, given_point_left, given_point_right], [], [])
targets = [left_side]

steps = [:circle, :circle, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 14 points; 1 lines; 4 circles
# Point #0 is predefined. Coordinates: (-0.66042, -0.14388)
# Point #1 is predefined. Coordinates: (0.93712, -0.62314)
# Point #2 is predefined. Coordinates: (0.00000, 0.00000)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (0.93712, -0.62314). Radius: 1.12538
# Circle #4 is centered at Point #2 and passes Point #1. Center: (0.00000, 0.00000). Radius: 1.12538
# Point #5 is intersection of Circle #3, Circle #4. Coordinates: (1.00821, 0.50000)
# Circle #6 is centered at Point #5 and passes Point #2. Center: (1.00821, 0.50000). Radius: 1.12538
# Point #7 is intersection of Circle #6, Circle #4. Coordinates: (0.07109, 1.12314)
# Line #8 passes Point #0, Point #7. Norm direction: 150.00000. Distance to origin: 0.50000
# Line #8 is a target