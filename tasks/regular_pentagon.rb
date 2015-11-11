# regular pentagon
require './geometric-constructions'

origin = Point.new([0, 0])
top_point = Point.new([0, 1])
circle = Circle.new(origin, top_point)

theta = 360 / 5 * Math::PI / 180

up_right = Point.new([Math.sin(theta), Math.cos(theta)])
down_right = Point.new([Math.sin(2*theta), Math.cos(2*theta)])

bottom_point = Line.new([origin, top_point]).intersection_with_line(Line.new([up_right, down_right])).first


initial_layout = Layout.new([origin, top_point], [], [circle])
targets = [Line.new([up_right, down_right])]

steps = [:line, :circle, :circle, :line, :circle, :line]

filters = {4 => [ bottom_point ]}

task = Task.new(initial_layout, targets, steps, filters)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 23 points; 3 lines; 4 circles
# Point #0 is predefined. Coordinates: (0.0, 0.0)
# Point #1 is predefined. Coordinates: (0.0, 1.0)
# Line #2 passes Point #0, Point #1. Norm direction: 0.0. Distance to origin: 0.0
# Circle #3 is predefined. Center: (0.0, 0.0). Radius: 1.0
# Point #4 is intersection of Line #2, Circle #3. Coordinates: (0.0, -1.0)
# Circle #5 is centered at Point #4 and passes Point #0. Center: (0.0, -1.0). Radius: 1.0
# Point #6 is intersection of Circle #5, Circle #3. Coordinates: (0.8660254037844386, -0.5)
# Point #7 is intersection of Line #2, Circle #5. Coordinates: (0.0, -2.0)
# Circle #8 is centered at Point #7 and passes Point #0. Center: (0.0, -2.0). Radius: 2.0
# Point #9 is intersection of Circle #8, Circle #3. Coordinates: (0.9682458365518543, -0.25)
# Line #10 passes Point #6, Point #9. Norm direction: 337.76124390703507. Distance to origin: 0.9908394147293549
# Point #11 is intersection of Line #10, Line #2. Coordinates: (0.0, -2.618033988749892)
# Circle #12 is centered at Point #4 and passes Point #11. Center: (0.0, -1.0). Radius: 1.6180339887498918
# Point #13 is intersection of Circle #12, Circle #3. Coordinates: (0.9510565162951551, 0.30901699437494257)
# Line #14 passes Point #11, Point #13. Norm direction: 341.99999999999994. Distance to origin: 0.8090169943749497
# Line #14 is a target
