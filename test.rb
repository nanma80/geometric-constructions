# three segments with E moves
require './geometric-constructions'

origin = Point.new([0, 0])
right_bottom = Point.new([1, 0])
theta_1 = 123 * Math::PI / 180
theta_2 = 34 * Math::PI / 180
middle_left_line = Point.new([Math.cos(theta_1), Math.sin(theta_1)])
top = Point.new([Math.cos(theta_1) + Math.cos(theta_2), Math.sin(theta_1) + Math.sin(theta_2)])

bottom_line = Line.new([origin, right_bottom])
left_line = Line.new([middle_left_line, top])
left_bottom = bottom_line.intersection_with_line(left_line).first

initial_layout = Layout.new([left_bottom, top, right_bottom], [left_line, bottom_line], [])

targets = [Point.new([-0.5085100696026763, -2.4994068439781003])] # point from previous solution

steps = [:circle] * 4 + [:line]

p steps

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

