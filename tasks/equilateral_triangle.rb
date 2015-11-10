require './geometric-constructions'

height = 2.731

top_point = Point.new([0, height])
up_line = Line.new([Point.new([0, 1]), Point.new([10, 1])])
down_line = Line.new([Point.new([0, -1]), Point.new([10, -1])])

x = - 0.3
random_down_point = Point.new([x, - 1])

sqrt3 = Math.sqrt(3.0)
left_corner = Point.new([sqrt3 - height/sqrt3, - 1])
initial_layout = Layout.new([top_point, random_down_point], [up_line, down_line], [])
targets = [left_corner]
steps = [:circle, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)
solution_layout = task.solve
solution_layout.print(targets)

# Found a solution
# Layout has 20 points; 3 lines; 3 circles
# Line #0 is predefined. Norm direction: 90.0. Distance to origin: 1.0
# Point #1 is predefined. Coordinates: (0.0, 2.731)
# Point #2 is predefined. Coordinates: (-0.3, -1.0)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (0.0, 2.731). Radius: 3.7430416775665214
# Point #4 is intersection of Line #0, Circle #3. Coordinates: (3.3187346986464585, 0.9999999999999998)
# Circle #5 is centered at Point #4 and passes Point #1. Center: (3.3187346986464585, 0.9999999999999998). Radius: 3.7430416775665214
# Point #6 is intersection of Circle #5, Circle #3. Coordinates: (0.16027737537236586, -1.0086085574487267)
# Point #7 is intersection of Line #0, Circle #3. Coordinates: (-3.3187346986464585, 1.0000000000000002)
# Circle #8 is centered at Point #7 and passes Point #1. Center: (-3.3187346986464585, 1.0000000000000002). Radius: 3.7430416775665214
# Point #9 is intersection of Circle #8, Circle #3. Coordinates: (-3.158457323274092, 4.739608557448727)
# Line #10 passes Point #6, Point #9. Norm direction: 209.99999999999997. Distance to origin: 0.3655
# Line #11 is predefined. Norm direction: 270.0. Distance to origin: 1.0
# Point #12 is intersection of Line #10, Line #11. Coordinates: (0.1553072224120086, -1.0)
# Point #12 is a target
