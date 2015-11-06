require './geometric-constructions'

center_point = Point.new([0, 0])
right_point = Point.new([1, 0])
horizontal_line = Line.new([center_point, right_point])
initial_circle = Circle.new(center_point, right_point)

up_distance = 2.23
theta = 54 * Math::PI / 180
up_point = Point.new([up_distance * Math.cos(theta), up_distance * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

initial_layout = Layout.new([center_point, right_point], [horizontal_line], [initial_circle])
targets = [line2]

steps = [:circle, :circle, :line, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 21 points; 3 lines; 4 circles
# Point #0 is predefined. Coordinates: (0.0, 0.0)
# Line #1 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #2 is predefined. Coordinates: (1.0, 0.0)
# Circle #3 is centered at Point #2 and passes Point #0. Center: (1.0, 0.0). Radius: 1.0
# Point #4 is intersection of Line #1, Circle #3. Coordinates: (2.0, -1.2246467991473532e-16)
# Circle #5 is predefined. Center: (0.0, 0.0). Radius: 1.0
# Point #6 is intersection of Circle #3, Circle #5. Coordinates: (0.5, 0.8660254037844386)
# Circle #7 is centered at Point #4 and passes Point #0. Center: (2.0, -1.2246467991473532e-16). Radius: 2.0
# Point #8 is intersection of Circle #7, Circle #5. Coordinates: (0.25, -0.9682458365518543)
# Line #9 passes Point #6, Point #8. Norm direction: 352.23875609296493. Distance to origin: 0.37846697903356036
# Point #10 is intersection of Line #9, Line #1. Coordinates: (0.38196601125010515, -2.338867265302616e-17)
# Circle #11 is centered at Point #4 and passes Point #10. Center: (2.0, -1.2246467991473532e-16). Radius: 1.618033988749895
# Point #12 is intersection of Circle #11, Circle #3. Coordinates: (0.6909830056250528, 0.9510565162951535)
# Line #13 passes Point #0, Point #12. Norm direction: 324.0. Distance to origin: 0.0
# Line #13 is a target
