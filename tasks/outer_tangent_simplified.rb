require './geometric-constructions'

ratio = 1.7
distance1 = 1.0
radius1 = 0.0333
center1 = Point.new([distance1, 0])
center2 = Point.new([distance1 * ratio, 0])

top1 = Point.new([distance1, radius1])
top2 = Point.new([distance1 * ratio, radius1 * ratio])

circle1 = Circle.new(center1, top1)
circle2 = Circle.new(center2, top2)

theta = Math.asin(radius1/distance1)
tangent_line = Line.new([Point.new([0, 0]), Point.new([Math.cos(theta), Math.sin(theta)])])
# tangent_point = tangent_line.intersection_with_circle(circle1).first

initial_layout = Layout.new([center1, center2], [], [circle1, circle2])

horizontal_line = Line.new([center1, center2])
vertical_line = Line.perp_bis([center1, center2])

# target_center = horizontal_line.intersection_with_line(vertical_line).first
targets = [tangent_line]

initial_layout.add_entity(horizontal_line)
initial_layout.add_entity(vertical_line)


steps = [:perp_bis, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 29 points; 4 lines; 4 circles
# Point #0 is predefined. Coordinates: (1.0333, -6.3271376877948e-17)
# Point #1 is predefined. Coordinates: (1.64339, -1.0062861516253843e-16)
# Line #2 is perpendicular bisector of Point #0, Point #1. Norm direction: 360.0. Distance to origin: 1.3383450000000001
# Point #3 is predefined. Coordinates: (1.3499999999999999, -8.266365894244633e-17)
# Point #4 is predefined. Coordinates: (1.0, 0.0)
# Circle #5 is centered at Point #3 and passes Point #4. Center: (1.3499999999999999, -8.266365894244633e-17). Radius: 0.34999999999999987
# Point #6 is intersection of Line #2, Circle #5. Coordinates: (1.3383450000000001, 0.3498058904235317)
# Circle #7 is centered at Point #6 and passes Point #0. Center: (1.3383450000000001, 0.3498058904235317). Radius: 0.46412995270721313
# Circle #8 is predefined. Center: (1.0, 0.0). Radius: 0.0333
# Point #9 is intersection of Circle #7, Circle #8. Coordinates: (0.9988911100000002, 0.03328153186029614)
# Circle #10 is predefined. Center: (1.7, 0.0). Radius: 0.05661
# Point #11 is intersection of Circle #7, Circle #10. Coordinates: (1.698114887, 0.05657860416250321)
# Line #12 passes Point #9, Point #11. Norm direction: 271.9083022515373. Distance to origin: 0.0
# Line #12 is a target
