require './geometric-constructions'

point_top = Point.new([0, 1])
point_left = Point.new([-1.3, 0])
point_right = Point.new([1.763, 0])
horizontal_line = Line.new([point_left, point_right])
vertical_line = Line.new([point_top, Point.new([0, 2])]) # target. operations: circle, circle, line

initial_layout = Layout.new([point_top, point_left, point_right], [horizontal_line], [])
targets = [vertical_line]

task = Task.new(initial_layout, targets, [:circle, :circle, :line])
solution_layout = task.solve

solution_layout.print(targets)
