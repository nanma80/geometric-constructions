require './geometric-constructions'

short = 1.0
long = 2.23
harmonic_mean = 2 * short * long/(short + long)
center_point = Point.new([0, 0])
left_point = Point.new([- short, 0])
right_point = Point.new([long, 0])
horizontal_line = Line.new([center_point, left_point])

theta = 34 * Math::PI / 180
up_point = Point.new([harmonic_mean * Math.cos(theta), harmonic_mean * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

initial_layout = Layout.new([center_point, left_point, right_point], [horizontal_line, line2], [])
targets = [up_point]

steps = [:circle, :circle, :line, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 13 points; 4 lines; 2 circles
# Point #0 is predefined. Coordinates: (2.23, 0.0)
# Point #1 is predefined. Coordinates: (-1.0, 0.0)
# Line #2 is predefined. Norm direction: 304.0. Distance to origin: 0.0
# Point #3 is predefined. Coordinates: (0.0, 0.0)
# Circle #4 is centered at Point #3 and passes Point #1. Center: (0.0, 0.0). Radius: 1.0
# Point #5 is intersection of Line #2, Circle #4. Coordinates: (0.8290375725550416, 0.559192903470747)
# Line #6 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #7 is intersection of Line #6, Circle #4. Coordinates: (1.0, -6.123233995736766e-17)
# Circle #8 is centered at Point #5 and passes Point #7. Center: (0.8290375725550416, 0.559192903470747). Radius: 0.5847434094454738
# Point #9 is intersection of Circle #8, Circle #4. Coordinates: (0.37460659341591157, 0.9271838545667875)
# Line #10 passes Point #1, Point #9. Norm direction: 124.00000000000001. Distance to origin: 0.5591929034707471
# Point #11 is intersection of Line #10, Circle #8. Coordinates: (0.6580751451100827, 1.118385806941494)
# Line #12 passes Point #0, Point #11. Norm direction: 54.56908618334314. Distance to origin: 1.292777581314239
# Point #13 is intersection of Line #12, Line #2. Coordinates: (1.1447391868716674, 0.7721363311082141)
# Point #13 is a target
