require './geometric-constructions'

radius = 2.47
center = Point.new([0, 1])
x = Math.sqrt(radius ** 2.0 - 1)
top_of_circle = Point.new([0, 1 + radius])
circle = Circle.new(center, top_of_circle)

random_point = Point.new([x, - 2.83])

horizontal_line = Line.new([Point.new([-8.26, 0]), Point.new([10.25, 0])])

point_dl = Point.new([-x, 0])
point_dr = Point.new([x, 0])
point_ul = Point.new([-x, 2])
point_ur = Point.new([x, 2])

line_dl_ur = Line.new([point_dl, point_ur])
line_dr_ul = Line.new([point_dr, point_ul])
line_right = Line.new([point_dr, point_ur])

initial_layout = Layout.new([random_point, center, point_ur, point_dr, point_ul, point_dl], [horizontal_line, line_right, line_dr_ul, line_dl_ur], [circle])

vertical_line = Line.new([center, top_of_circle])
point_left_mirror = Point.new([x, -2])
targets = [point_left_mirror]

steps = [:line] * 4

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 20 points; 8 lines; 1 circles
# Point #0 is predefined. Coordinates: (-2.258517212686235, 2.0)
# Point #1 is predefined. Coordinates: (2.258517212686235, -2.83)
# Point #2 is predefined. Coordinates: (0.0, 1.0)
# Line #3 passes Point #1, Point #2. Norm direction: 30.52747780082198. Distance to origin: 0.5079515230510201
# Line #4 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #5 is intersection of Line #3, Line #4. Coordinates: (0.5896911782470587, -3.6108170696284595e-17)
# Point #6 is predefined. Coordinates: (-2.258517212686235, 0.0)
# Line #7 passes Point #1, Point #6. Norm direction: 237.93214637706726. Distance to origin: 1.199099207439854
# Line #8 is predefined. Norm direction: 66.1177522296179. Distance to origin: 0.9143794383345082
# Point #9 is intersection of Line #7, Line #8. Coordinates: (-13.142937514788557, 6.819277108433729)
# Line #10 passes Point #5, Point #9. Norm direction: 63.592164226201845. Distance to origin: 0.2622696759979181
# Line #11 is predefined. Norm direction: 113.8822477703821. Distance to origin: 0.9143794383345082
# Point #12 is intersection of Line #10, Line #11. Coordinates: (-0.7528390708954118, 0.6666666666666667)
# Line #13 passes Point #0, Point #12. Norm direction: 48.47392990748581. Distance to origin: 0.0
# Line #14 is predefined. Norm direction: 0.0. Distance to origin: 2.258517212686235
# Point #15 is intersection of Line #13, Line #14. Coordinates: (2.258517212686235, -1.9999999999999998)
# Point #15 is a target

# note: Line #14 intersects with the horizontal_line at (0, 0), which is enough to solve the puzzle
