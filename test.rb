require './geometric-constructions'

left_bottom = Point.new([0, 0])
left_top = Point.new([1, 2])

right_bottom = Point.new([3, 1])
right_top = Point.new([4, 3])

left_line = Line.new([left_top, left_bottom])
right_line = Line.new([right_top, right_bottom])

initial_layout = Layout.new([left_bottom, left_top, right_bottom], [left_line], [])
targets = [right_line, right_top]

steps = [:parallel, :compass]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)
