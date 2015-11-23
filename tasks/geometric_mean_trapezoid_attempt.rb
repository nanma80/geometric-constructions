# geometric mean in trapezoid part 1
# Solved manually. Saved one step between a circle and perp_bis.

require './geometric-constructions'

top_width = 1.15
bottom_width = 2.703
height = 1.332
left_shift = 0.84

mean_width = Math.sqrt(top_width * bottom_width)

ld_point = Point.new([0, 0])
rd_point = Point.new([bottom_width, 0])
lu_point = Point.new([left_shift, height])
ru_point = Point.new([left_shift + top_width, height])

top_line = Line.new([lu_point, ru_point])
bottom_line = Line.new([ld_point, rd_point])
left_line = Line.new([lu_point, ld_point])
right_line = Line.new([ru_point, rd_point])

initial_layout = Layout.new([ld_point, rd_point, lu_point, ru_point], [top_line, bottom_line, left_line, right_line], [])

# circle
circle1 = Circle.new(lu_point, ru_point)

initial_layout.add_entity(circle1)

puts initial_layout.points.length

top_left = Point.new([left_shift - top_width, height])
raise unless initial_layout.contains?([top_left])

# circle
circle2 = Circle.new(ld_point, top_left)
initial_layout.add_entity(circle2)
puts initial_layout.points.length

circle1_2 = circle1.intersection_with_circle(circle2)[1]

raise unless initial_layout.contains?([circle1_2])

# line
line3 = Line.new([ru_point, circle1_2])
initial_layout.add_entity(line3)
puts initial_layout.points.length

top_on_bottom = Point.new([top_width, 0])

raise unless initial_layout.contains?([top_on_bottom])

# perp_bis
perp_bis_line = Line.perp_bis([ld_point, rd_point])
initial_layout.add_entity(perp_bis_line)
puts initial_layout.points.length

raise unless initial_layout.contains?([Point.new([bottom_width / 2.0, 0])])

# circle
circle5 = Circle.new(top_on_bottom, ld_point)
initial_layout.add_entity(circle5)
puts initial_layout.points.length

circle5_perp_bis = circle5.intersection_with_line(perp_bis_line)[0]

raise unless initial_layout.contains?([circle5_perp_bis])

# circle
circle6 = Circle.new(ld_point, circle5_perp_bis)
initial_layout.add_entity(circle6)
puts initial_layout.points.length

mean_on_bottom = Point.new([mean_width, 0])
raise unless initial_layout.contains?([mean_on_bottom])

# line
cross_line = Line.new([mean_on_bottom, top_left])
initial_layout.add_entity(cross_line)
puts initial_layout.points.length

left_end = cross_line.intersection_with_line(left_line).first
raise unless initial_layout.contains?([left_end])




targets = [Line.new([left_end, Point.new([0, left_end.y])])]

steps = [:line, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)


# Solution of the first four moves
# First extend the top line
# Found a solution
# Layout has 15 points; 5 lines; 2 circles
# Line #0 is predefined. Norm direction: 327.76321344786976. Distance to origin: 0.0
# Point #1 is predefined. Coordinates: (0.0, 0.0)
# Point #2 is predefined. Coordinates: (0.84, 1.332)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (0.0, 0.0). Radius: 1.5747456937550266
# Point #4 is intersection of Line #0, Circle #3. Coordinates: (-0.8400000000000005, -1.3319999999999996)
# Line #5 is predefined. Norm direction: 90.0. Distance to origin: 1.332
# Point #6 is predefined. Coordinates: (1.9899999999999998, 1.332)
# Circle #7 is centered at Point #6 and passes Point #2. Center: (1.9899999999999998, 1.332). Radius: 1.15
# Point #8 is intersection of Line #5, Circle #7. Coordinates: (3.1399999999999997, 1.3319999999999999)
# Line #9 passes Point #4, Point #8. Norm direction: 303.7962444338812. Distance to origin: 0.6396773176369306
# Line #10 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #11 is intersection of Line #9, Line #10. Coordinates: (1.1499999999999997, -7.041719095097279e-17)
# Point #11 is a target
