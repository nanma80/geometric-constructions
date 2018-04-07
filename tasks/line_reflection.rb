# 13.7 line reflection

require './geometric-constructions'

origin = Point.new([0, 0])
point_theta = 26 * Math::PI / 180

point_distance = 1
point_a = Point.new([point_distance * Math.cos(point_theta), point_distance * Math.sin(point_theta)]).with_name('point a')
point_reflected_a = Point.new([-point_distance * Math.cos(point_theta), point_distance * Math.sin(point_theta)])
random_point1 = Point.new([1.234, 0]).with_name('random point 1 on x')
random_point2 = Point.new([4.13, 0]).with_name('random point 2 on x')

x_axis = Line.new([origin, Point.new([1, 0])]).with_name('x axis')
y_axis = Line.new([origin, Point.new([0, 1])]).with_name('y axis')
point_a_line = Line.new([origin, point_a]).with_name('given line')
target_line = Line.new([origin, point_reflected_a])

initial_layout = Layout.new([origin, point_a, random_point1, random_point2], [x_axis, y_axis, point_a_line], [])
targets = [target_line]

steps = [:line] * 5

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 11 points; 8 lines; 0 circles
# Point #0 is predefined. Coordinates: (0.00000, 0.00000)
# Point #1 is the random point 2 on x. Coordinates: (4.13000, 0.00000)
# Point #2 is the random point 1 on x. Coordinates: (1.23400, 0.00000)
# Point #3 is the point a. Coordinates: (0.89879, 0.43837)
# Line #4 passes Point #3, Point #2. Norm direction: 37.40379. Distance to origin: 0.98026
# Line #5 is the y axis. Norm direction: 0.00000. Distance to origin: 0.00000
# Point #6 is intersection of Line #4, Line #5. Coordinates: (0.00000, 1.61378)
# Line #7 passes Point #1, Point #6. Norm direction: 68.65709. Distance to origin: 1.50311
# Line #8 is the given line. Norm direction: 296.00000. Distance to origin: 0.00000
# Point #9 is intersection of Line #7, Line #8. Coordinates: (1.83702, 0.89597)
# Line #10 passes Point #2, Point #9. Norm direction: 326.05817. Distance to origin: 1.02373
# Point #11 is intersection of Line #10, Line #5. Coordinates: (0.00000, -1.83349)
# Line #12 passes Point #1, Point #11. Norm direction: 293.93859. Distance to origin: 1.67578
# Point #13 is intersection of Line #12, Line #4. Coordinates: (1.96795, -0.95983)
# Line #14 passes Point #0, Point #13. Norm direction: 64.00000. Distance to origin: 0.00000
# Line #14 is a target