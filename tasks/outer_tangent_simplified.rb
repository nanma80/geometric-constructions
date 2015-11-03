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
