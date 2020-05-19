require './geometric-constructions'


center = Point.new([0, 0]).with_name('center of circle')
circle_top = Point.new([0, 1]).with_name('not an input')
circle = Circle.new(center, circle_top).with_name('circle')

x_a = 0.7133
x_b = 0.3567
point_a = Point.new([-x_a, 0]).with_name('point a')
point_b = Point.new([x_b, 0]).with_name('point b')

# center_outside = 2 * x_a * x_b / (x_a - x_b)
center_outside =  x_a **2/(x_a - x_b) - x_a

# (x_a - x_b)/(x_a + x_b) == (x_a + x_b)/(y + x_a)

point_outside = Point.new([center_outside, 0])

circle_outside = Circle.new(point_outside, center)

ints = circle.intersection_with_circle(circle_outside)
target = ints[1]

puts 'target point:'
pp target.coordinates

# pp point_a.coordinates
# pp point_b.coordinates
# pp center.coordinates
# pp center_outside
# pp point_outside.coordinates

initial_layout = Layout.new([center, point_a, point_b], [], [circle])

targets = [target]
# targets = [point_outside]

# l moves
steps = [:perp_bis, :circle, :line, :circle, :line]
# e moves
# steps = [:line, :circle, :circle, :line, :line]

filters = {}

task = Task.new(initial_layout, targets, steps, filters)

solution_layout = task.solve

solution_layout.print(targets)

# L solution
# Layout has 21 points; 3 lines; 3 circles
# Point #0 is the center of circle. Coordinates: (0.00000, 0.00000)
# Point #1 is the point b. Coordinates: (0.35670, 0.00000)
# Point #2 is the point a. Coordinates: (-0.71330, 0.00000)
# Line #3 is perpendicular bisector of Point #1, Point #2. Norm direction: 180.00000. Distance to origin: 0.17830
# Circle #4 is the circle. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #5 is intersection of Line #3, Circle #4. Coordinates: (-0.17830, -0.98398)
# Circle #6 is centered at Point #5 and passes Point #2. Center: (-0.17830, -0.98398). Radius: 1.12002
# Point #7 is intersection of Circle #6, Circle #4. Coordinates: (0.84658, -0.53226)
# Line #8 passes Point #0, Point #7. Norm direction: 57.84189. Distance to origin: 0.00000
# Point #9 is intersection of Line #8, Circle #6. Coordinates: (-0.21540, 0.13542)
# Circle #10 is centered at Point #0 and passes Point #9. Center: (0.00000, 0.00000). Radius: 0.25443
# Point #11 is intersection of Line #3, Circle #10. Coordinates: (-0.17830, -0.18151)
# Line #12 passes Point #0, Point #11. Norm direction: 315.51112. Distance to origin: 0.00000
# Point #13 is intersection of Line #12, Circle #4. Coordinates: (0.70077, 0.71339)
# Point #13 is a target

# E solution
# Layout has 18 points; 3 lines; 3 circles
# Point #0 is the point a. Coordinates: (-0.71330, 0.00000)
# Point #1 is the center of circle. Coordinates: (0.00000, 0.00000)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (-0.71330, 0.00000). Radius: 0.71330
# Circle #3 is the circle. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (-0.70097, -0.71319)
# Point #5 is the point b. Coordinates: (0.35670, 0.00000)
# Line #6 passes Point #5, Point #0. Norm direction: 90.00000. Distance to origin: 0.00000
# Circle #7 is centered at Point #1 and passes Point #5. Center: (0.00000, 0.00000). Radius: 0.35670
# Point #8 is intersection of Line #6, Circle #7. Coordinates: (-0.35670, 0.00000)
# Point #9 is intersection of Circle #2, Circle #3. Coordinates: (-0.70097, 0.71319)
# Line #10 passes Point #8, Point #9. Norm direction: 205.76718. Distance to origin: 0.32123
# Point #11 is intersection of Line #10, Circle #2. Coordinates: (-0.14721, -0.43398)
# Line #12 passes Point #4, Point #11. Norm direction: 296.75785. Distance to origin: 0.32123
# Point #13 is intersection of Line #12, Line #6. Coordinates: (0.71350, -0.00000)
# Point #13 is a target

