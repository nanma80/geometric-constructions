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

targets = [origin]

steps = [:line, :parallel, :compass, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 22 points; 5 lines; 2 circles
# Point #0 is predefined. Coordinates: (0.28439853754001454, 1.397863471416171)
# Point #1 is predefined. Coordinates: (1.0, 0.0)
# Line #2 passes Point #0, Point #1. Norm direction: 27.109048307724127. Distance to origin: 0.890140852600904
# Point #3 is predefined. Coordinates: (-1.788019284491324, 1.0948460467830204e-16)
# Line #4 is parallel to Line #2 and passes Point #3. Norm direction: 207.10904830772415. Distance to origin: 1.5915890103639656
# Line #5 is predefined. Norm direction: 124.00000000000001. Distance to origin: 0.9998476951563913
# Circle #6 is centered at Point #0 and radius is the distance between Point #3, Point #1. Center: (0.28439853754001454, 1.397863471416171). Radius: 2.788019284491324
# Point #7 is intersection of Line #5, Circle #6. Coordinates: (-2.026974202311316, -0.16117712721096678)
# Circle #8 is centered at Point #7 and passes Point #0. Center: (-2.026974202311316, -0.16117712721096678). Radius: 2.7880192844913236
# Point #9 is intersection of Line #4, Circle #8. Coordinates: (-0.5085100696026763, -2.4994068439781003)
# Line #10 passes Point #0, Point #9. Norm direction: 348.49999999999994. Distance to origin: 0.0
# Line #11 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #12 is intersection of Line #10, Line #11. Coordinates: (0.0, 0.0)
# Point #12 is a target
