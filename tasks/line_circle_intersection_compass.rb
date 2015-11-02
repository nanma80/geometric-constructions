require './geometric-constructions'

center = Point.new([0, -1])
circle_top = Point.new([0, 0.34])
circle = Circle.new(center, circle_top)

point_left = Point.new([-1.3, 0])
point_right = Point.new([1.763, 0])

hidden_line = Line.new([point_left, point_right])

targets = circle.intersection_with_line(hidden_line)

initial_layout = Layout.new([point_left, point_right, center], [], [circle])

task = Task.new(initial_layout, targets, [:circle, :circle, :circle, :circle])
solution_layout = task.solve

solution_layout.print(targets)
