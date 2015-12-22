require './geometric-constructions'

top_x = 0.5
top_y = Math.sqrt(3.0) * 0.5

foot = Point.new([0, 0])

angle = 24.74 * Math::PI / 180.0
up_point = Point.new([- Math.cos(angle), Math.sin(angle)])
down_point = Point.new([- Math.cos(angle), -Math.sin(angle)])

random_point = Point.new([-0.231, 0])

horizontal_line = Line.new([foot, Point.new([1, 0])])
up_line = Line.new([foot, up_point])
down_line = Line.new([foot, down_point])

generator_line = Line.new([Point.new([-1, 0]), Point.new([-0.5, - 3.17])])

given_up_point = generator_line.intersection_with_line(up_line).first
given_down_point = generator_line.intersection_with_line(down_line).first

initial_layout = Layout.new([random_point, given_up_point, given_down_point], [horizontal_line], [])

targets = [up_line]

steps = [:circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 11 points; 2 lines; 2 circles
# Point #0 is predefined. Coordinates: (-1.078377039501757, 0.4969104304411402)
# Line #1 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #2 is predefined. Coordinates: (-0.231, 0.0)
# Point #3 is predefined. Coordinates: (-0.9322439912472364, -0.4295730954925212)
# Circle #4 is centered at Point #2 and passes Point #3. Center: (-0.231, 0.0). Radius: 0.8223601277003774
# Point #5 is intersection of Line #1, Circle #4. Coordinates: (0.5913601277003774, -3.621036437658186e-17)
# Circle #6 is centered at Point #5 and passes Point #3. Center: (0.5913601277003774, -3.621036437658186e-17). Radius: 1.5830042816256564
# Point #7 is intersection of Circle #6, Circle #4. Coordinates: (-0.9322439912472357, 0.42957309549252215)
# Line #8 passes Point #0, Point #7. Norm direction: 65.26000000000036. Distance to origin: 0.0
# Line #8 is a target
