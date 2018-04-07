# 11.9 point farthest from angle sides

require './geometric-constructions'

origin = Point.new([0, 0])
angle_theta = Math::PI / 180 * 52.3
circle_theta = Math::PI / 180 * 23.7
circle_distance = 3.1
circle_radius = 0.52

angle_horizontal = LineSegment.new([origin, Point.new([100000003.1, 0])]).with_name('angle horizontal')
angle_side = LineSegment.new([origin, Point.new([1002303.1 * Math.cos(angle_theta), 1002303.1 * Math.sin(angle_theta)])]).with_name('angle side')

circle_center = Point.new([
  circle_distance * Math.cos(circle_theta), 
  circle_distance * Math.sin(circle_theta)]).with_name('circle center')

target_point = Point.new([
  circle_distance * Math.cos(circle_theta) + circle_radius * Math.cos(angle_theta / 2), 
  circle_distance * Math.sin(circle_theta) + circle_radius * Math.sin(angle_theta / 2)])

circle = Circle.new(circle_center, target_point)

initial_layout = Layout.new([origin, circle_center], [angle_horizontal, angle_side], [circle])
targets = [target_point]

steps = [:circle, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Layout has 21 points; 3 lines; 4 circles
# Point #0 is the circle center. Coordinates: (2.83855, 1.24604)
# LineSegment #1 is the angle horizontal. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #2 is predefined. Coordinates: (0.00000, 0.00000)
# Circle #3 is centered at Point #2 and passes Point #0. Center: (0.00000, 0.00000). Radius: 3.10000
# Point #4 is intersection of LineSegment #1, Circle #3. Coordinates: (3.10000, -0.00000)
# Circle #5 is centered at Point #4 and passes Point #0. Center: (3.10000, -0.00000). Radius: 1.27317
# LineSegment #6 is the angle side. Norm direction: 322.30000. Distance to origin: 0.00000
# Point #7 is intersection of LineSegment #6, Circle #3. Coordinates: (1.89573, 2.45279)
# Circle #8 is centered at Point #7 and passes Point #0. Center: (1.89573, 2.45279). Radius: 1.53139
# Point #9 is intersection of Circle #5, Circle #8. Coordinates: (2.27399, 0.96885)
# Line #10 passes Point #0, Point #9. Norm direction: 296.15000. Distance to origin: 0.13252
# Circle #11 is predefined. Center: (2.83855, 1.24604). Radius: 0.52000
# Point #12 is intersection of Line #10, Circle #11. Coordinates: (3.30533, 1.47521)
# Point #12 is a target