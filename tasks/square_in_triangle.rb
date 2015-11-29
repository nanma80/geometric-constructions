# Square in triangle
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


targets = [Point.new([top_x, 0]), Point.new([right_point.x, right_point.x - left_point.x])]


steps = [:perp] + [:circle] * 3

p steps

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)


# Found a solution
# Layout has 22 points; 4 lines; 3 circles
# Line #0 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #1 is predefined. Coordinates: (0.712, 1.352)
# Line #2 is perpendicular to Line #0 and passes Point #1. Norm direction: 0.0. Distance to origin: 0.7119999999999999
# Point #3 is intersection of Line #2, Line #0. Coordinates: (0.7119999999999999, -4.3597426049645764e-17)
# Point #3 is a target
# Point #4 is predefined. Coordinates: (1.8181818181818181, -1.1133152719521392e-16)
# Circle #5 is centered at Point #3 and passes Point #4. Center: (0.7119999999999999, -4.3597426049645764e-17). Radius: 1.1061818181818182
# Point #6 is intersection of Line #2, Circle #5. Coordinates: (0.7119999999999999, -1.1061818181818182)
# Point #7 is predefined. Coordinates: (-2.0227272727272725, 1.2385632400467546e-16)
# Circle #8 is centered at Point #4 and passes Point #7. Center: (1.8181818181818181, -1.1133152719521392e-16). Radius: 3.840909090909091
# Point #9 is intersection of Line #0, Circle #8. Coordinates: (5.659090909090909, -3.4651937839510333e-16)
# Circle #10 is centered at Point #6 and passes Point #9. Center: (0.7119999999999999, -1.1061818181818182). Radius: 5.069255041688665
# Point #11 is intersection of Circle #10, Circle #8. Coordinates: (1.8181818181818183, 3.8409090909090913)
# Point #11 is a target

# Comment: Point #9 is not reachable in real game because of line segments ~= lines. But it can be worked around.
