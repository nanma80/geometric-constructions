require './geometric-constructions'

bottom_left = Point.new([0, 0])
top_left = Point.new([1, 2])
bottom_right = Point.new([3, 1])

targets = [Point.new([4, 3])]

initial_layout = Layout.new([bottom_left, bottom_right, top_left], [], [])

steps = [:line, :line, :parallel, :parallel]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)
