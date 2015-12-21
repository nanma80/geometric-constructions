# Square in triangle 12E
require './geometric-constructions'

top_x = 0.712
top_y = 1.352

ld_square = Point.new([0, 0])
rd_square = Point.new([1, 0])
lu_square = Point.new([0, 1])
ru_square = Point.new([1, 1])

top = Point.new([top_x, top_y])
bottom_line = Line.new([ld_square, rd_square])

left_line = Line.new([top, lu_square])
right_line = Line.new([top, ru_square])

left_point = left_line.intersection_with_line(bottom_line).first
right_point = right_line.intersection_with_line(bottom_line).first

initial_layout = Layout.new([top, left_point, right_point], [bottom_line, left_line, right_line], [])

targets = [Line.new([ru_square, rd_square])]

steps = [:perp, :circle, :line, :perp]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 16 points; 6 lines; 1 circles
# Line #0 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #1 is predefined. Coordinates: (0.712, 1.352)
# Point #2 is predefined. Coordinates: (1.8181818181818181, -1.1133152719521392e-16)
# Line #3 is perpendicular to Line #0 and passes Point #2. Norm direction: 0.0. Distance to origin: 1.8181818181818181
# Point #4 is predefined. Coordinates: (-2.0227272727272725, 1.2385632400467546e-16)
# Circle #5 is centered at Point #2 and passes Point #4. Center: (1.8181818181818181, -1.1133152719521392e-16). Radius: 3.840909090909091
# Point #6 is intersection of Line #3, Circle #5. Coordinates: (1.8181818181818181, -3.840909090909091)
# Line #7 passes Point #1, Point #6. Norm direction: 12.025279609635316. Distance to origin: 0.9780557723089518
# Point #8 is intersection of Line #7, Line #0. Coordinates: (1.0, -6.123233995736766e-17)
# Line #9 is perpendicular to Line #0 and passes Point #8. Norm direction: 0.0. Distance to origin: 1.0
# Line #9 is a target
