# 13.9 Square by Four Points 7L

require './geometric-constructions'


point_a = Point.new([-0.313, 0]).with_name('point a')
point_b = Point.new([1.217, 1]).with_name('point b')
point_1 = Point.new([0, 0.8676]).with_name('point 1')
point_2 = Point.new([1, 0.1832]).with_name('point 2')
point_up_left = Point.new([0, 1])
point_down_right = Point.new([1, 0])

line_up = Line.new([point_b, point_up_left])
line_left = Line.new([point_1, point_up_left])
line_down = Line.new([point_a, point_down_right])
line_right = Line.new([point_2, point_down_right])

initial_layout = Layout.new([point_a, point_b, point_1, point_2], [], [])

targets = [line_up]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

steps = [:line, :perp, :compass, :line]
step_count = steps.length

filters = {}
# filters = {3 => [origin]}

task = Task.new(initial_layout, targets, steps, filters)
solution_layout = task.solve
solution_layout.print(targets)

# Layout has 11 points; 3 lines; 1 circles
# Point #0 is the point b. Coordinates: (1.21700, 1.00000)
# Point #1 is the point 1. Coordinates: (0.00000, 0.86760)
# Point #2 is the point 2. Coordinates: (1.00000, 0.18320)
# Line #3 passes Point #1, Point #2. Norm direction: 55.61226. Distance to origin: 0.71597
# Point #4 is the point a. Coordinates: (-0.31300, 0.00000)
# Line #5 is perpendicular to Line #3 and passes Point #4. Norm direction: 145.61226. Distance to origin: 0.25830
# Circle #6 is centered at Point #4 and radius is the distance between Point #2, Point #1. Center: (-0.31300, 0.00000). Radius: 1.21178
# Point #7 is intersection of Line #5, Circle #6. Coordinates: (0.37140, 1.00000)
# Line #8 passes Point #0, Point #7. Norm direction: 90.00000. Distance to origin: 1.00000
# Line #8 is a target
