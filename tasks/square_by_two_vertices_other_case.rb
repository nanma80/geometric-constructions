require './geometric-constructions'

left_point = Point.new([0, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')

target_left = Point.new([0, 1]).with_name('left target')
target_right = Point.new([1, 1]).with_name('right target')

target_up = Point.new([0.5, 0.5]).with_name('up target')
target_down = Point.new([0.5, -0.5]).with_name('down target')


initial_layout = Layout.new([left_point, right_point], [], [])
targets = [target_up]

steps = [:circle] * 7

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 29 points; 0 lines; 7 circles
# Point #0 is the left point. Coordinates: (0.00000, 0.00000)
# Point #1 is the right point. Coordinates: (1.00000, 0.00000)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (0.00000, 0.00000). Radius: 1.00000
# Circle #3 is centered at Point #1 and passes Point #0. Center: (1.00000, 0.00000). Radius: 1.00000
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (0.50000, -0.86603)
# Point #5 is intersection of Circle #2, Circle #3. Coordinates: (0.50000, 0.86603)
# Circle #6 is centered at Point #4 and passes Point #5. Center: (0.50000, -0.86603). Radius: 1.73205
# Point #7 is intersection of Circle #6, Circle #3. Coordinates: (2.00000, -0.00000)
# Point #8 is intersection of Circle #6, Circle #2. Coordinates: (-1.00000, -0.00000)
# Circle #9 is centered at Point #8 and passes Point #1. Center: (-1.00000, -0.00000). Radius: 2.00000
# Point #10 is intersection of Circle #9, Circle #3. Coordinates: (0.75000, -0.96825)
# Circle #11 is centered at Point #7 and passes Point #10. Center: (2.00000, -0.00000). Radius: 1.58114
# Point #12 is intersection of Circle #9, Circle #3. Coordinates: (0.75000, 0.96825)
# Circle #13 is centered at Point #5 and passes Point #12. Center: (0.50000, 0.86603). Radius: 0.27009
# Point #14 is intersection of Circle #13, Circle #2. Coordinates: (0.25000, 0.96825)
# Circle #15 is centered at Point #8 and passes Point #14. Center: (-1.00000, -0.00000). Radius: 1.58114
# Point #16 is intersection of Circle #11, Circle #15. Coordinates: (0.50000, 0.50000)
# Point #16 is a target, the up target
