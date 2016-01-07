require './geometric-constructions'

top_x = 0.5
top_y = Math.sqrt(3.0) * 0.5

foot = Point.new([0, 0])
top = Point.new([top_x, top_y])
random_point = Point.new([-0.231, 0])

horizontal_line = Line.new([foot, Point.new([1, 0])])

initial_layout = Layout.new([top, random_point], [horizontal_line], [])

targets = [Line.new([foot, top])]

steps = [:circle, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 13 points; 2 lines; 3 circles
# Point #0 is predefined. Coordinates: (0.5, 0.8660254037844386)
# Line #1 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #2 is predefined. Coordinates: (-0.231, 0.0)
# Circle #3 is centered at Point #2 and passes Point #0. Center: (-0.231, 0.0). Radius: 1.1332965190099191
# Point #4 is intersection of Line #1, Circle #3. Coordinates: (-1.3642965190099192, 8.353906825466868e-17)
# Circle #5 is centered at Point #0 and passes Point #2. Center: (0.5, 0.8660254037844386). Radius: 1.1332965190099191
# Point #6 is intersection of Circle #5, Circle #3. Coordinates: (-0.6155000000000002, 1.066077272058644)
# Circle #7 is centered at Point #4 and passes Point #6. Center: (-1.3642965190099192, 8.353906825466868e-17). Radius: 1.3027728032475088
# Point #8 is intersection of Circle #7, Circle #3. Coordinates: (-0.6155000000000003, -1.066077272058644)
# Line #9 passes Point #0, Point #8. Norm direction: 329.99999999999994. Distance to origin: 0.0
# Line #9 is a target
