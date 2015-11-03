require './geometric-constructions'

ratio = 1.7
distance1 = 1.0
radius1 = 0.3
center1 = Point.new([distance1, 0])
center2 = Point.new([distance1 * ratio, 0])

top1 = Point.new([distance1, radius1])
top2 = Point.new([distance1 * ratio, radius1 * ratio])

circle1 = Circle.new(center1, top1)
circle2 = Circle.new(center2, top2)

theta = Math.asin(radius1/distance1)
targets = [Line.new([Point.new([0, 0]), Point.new([Math.cos(theta), Math.sin(theta)])])]

initial_layout = Layout.new([center1, center2], [], [circle1, circle2])
steps = [:line, :perp_bis, :perp_bis, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)
