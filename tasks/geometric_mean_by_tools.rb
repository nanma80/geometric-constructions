require './geometric-constructions'

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

solution_layout.print(targets)

# Processed 52500/1299042 layouts in this round
# Found a solution
# Layout has 24 points; 3 lines; 4 circles
# Line #0 is predefined. Norm direction: 304.0. Distance to origin: 0.0
# Point #1 is predefined. Coordinates: (0.0, 0.0)
# Line #2 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #3 is predefined. Coordinates: (-1.0, 0.0)
# Circle #4 is centered at Point #1 and passes Point #3. Center: (0.0, 0.0). Radius: 1.0
# Point #5 is intersection of Line #2, Circle #4. Coordinates: (1.0, -6.123233995736766e-17)
# Circle #6 is centered at Point #5 and passes Point #1. Center: (1.0, -6.123233995736766e-17). Radius: 1.0
# Point #7 is intersection of Circle #6, Circle #4. Coordinates: (0.5, 0.8660254037844385)
# Point #8 is intersection of Circle #6, Circle #4. Coordinates: (0.5, -0.8660254037844387)
# Line #9 passes Point #7, Point #8. Norm direction: 0.0. Distance to origin: 0.5
# Point #10 is predefined. Coordinates: (2.23, 0.0)
# Circle #11 is centered at Point #10 and passes Point #1. Center: (2.23, 0.0). Radius: 2.23
# Point #12 is intersection of Line #9, Circle #11. Coordinates: (0.5, -1.407124727947029)
# Circle #13 is centered at Point #1 and passes Point #12. Center: (0.0, 0.0). Radius: 1.493318452306808
# Point #14 is intersection of Line #0, Circle #13. Coordinates: (1.2380171047520878, 0.8350530811518861)
# Point #14 is a target
