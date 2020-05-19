require './geometric-constructions'


center = Point.new([0, 0]).with_name('center of circle')
circle_top = Point.new([0, 1]).with_name('not an input')
circle = Circle.new(center, circle_top).with_name('input circle')

line_y = - 1.2341
line_x1 = -1.7824
line_x2 = -0.34782

line_left_point = Point.new([line_x1, line_y]).with_name('line_left_point')
line_right_point = Point.new([line_x2, line_y]).with_name('line_right_point')
line = LineSegment.new([line_left_point, line_right_point]).with_name('input line')

line_length = line_x2 - line_x1

target_y = - Math.sqrt(1 - (line_length/2)**2)

target_line = Line.new([Point.new([1, target_y]), Point.new([0, target_y])]).with_name('target line')

initial_layout = Layout.new([center, line_left_point, line_right_point], [line], [circle])

targets = [target_line]

steps = [:line, :circle, :perp_bis, :line, :line]
steps = [:parallel, , :perp_bis, :parallel]

filters = {}

task = Task.new(initial_layout, targets, steps, filters)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 15 points; 5 lines; 2 circles
# Point #0 is the line_right_point. Coordinates: (-0.34782, -1.23410)
# Point #1 is the line_left_point. Coordinates: (-1.78240, -1.23410)
# Line #2 passes Point #0, Point #1. Norm direction: 270.00000. Distance to origin: 1.23410
# Point #3 is the center of circle. Coordinates: (0.00000, 0.00000)
# Circle #4 is centered at Point #3 and passes Point #1. Center: (0.00000, 0.00000). Radius: 2.16794
# Point #5 is intersection of Line #2, Circle #4. Coordinates: (1.78240, -1.23410)
# Line #6 is perpendicular bisector of Point #5, Point #0. Norm direction: 0.00000. Distance to origin: 0.71729
# Circle #7 is the input circle. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #8 is intersection of Line #6, Circle #7. Coordinates: (0.71729, -0.69677)
# Point #9 is intersection of Line #6, Circle #7. Coordinates: (0.71729, 0.69677)
# Line #10 passes Point #3, Point #9. Norm direction: 314.16881. Distance to origin: 0.00000
# Point #11 is intersection of Line #10, Circle #7. Coordinates: (-0.71729, -0.69677)
# Line #12 passes Point #8, Point #11. Norm direction: 270.00000. Distance to origin: 0.69677
# Line #12 is a target, the target line
