# 10.12 Center of Rotation 5E

require './geometric-constructions'

p11 = Point.new([0, 0]).with_name('p11')
p12 = Point.new([1, 0]).with_name('p12')
line1 = LineSegment.new([p11, p12]).with_name('line1')

x2 = 0.12
y2 = -0.3323
p21 = Point.new([x2, y2])

angle = 74.32 * Math::PI / 180.0
p22 = Point.new([x2 + Math.cos(angle), y2 + Math.sin(angle)])
line2 = LineSegment.new([p21, p22]).with_name('line2')

point_int = line1.intersection_with_line(line2).first
puts "point_int:"
pp point_int.coordinates

pb1 = Line.perp_bis([p11, p22])
pb2 = Line.perp_bis([p12, p21])

target_point = pb1.intersection_with_line(pb2).first

initial_layout = Layout.new([p11, p12, p21, p22, point_int], [line1, line2], [])
c1 = Circle.new(p21, p12)
c2 = Circle.new(p12, p21)
initial_layout << c1
initial_layout << c2

targets = [target_point]

steps = [:circle, :circle, :line, :circle, :line]
steps = [:line, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve()

solution_layout.print(targets)

# Layout has 22 points; 4 lines; 3 circles
# Point #0 is the p12. Coordinates: (1.00000, 0.00000)
# Point #1 is predefined. Coordinates: (0.05935, -0.00000)
# Point #2 is predefined. Coordinates: (0.37422, 0.57335)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (0.05935, -0.00000). Radius: 0.65412
# Circle #4 is predefined. Center: (0.12000, -0.33230). Radius: 0.94065
# Point #5 is intersection of Circle #3, Circle #4. Coordinates: (-0.43777, 0.42514)
# Line #6 passes Point #0, Point #5. Norm direction: 73.52722. Distance to origin: 0.28356
# Point #7 is predefined. Coordinates: (0.27222, 0.59595)
# Point #8 is predefined. Coordinates: (0.84778, -0.92825)
# Line #9 passes Point #7, Point #8. Norm direction: 20.68722. Distance to origin: 0.46520
# Point #10 is intersection of Line #6, Line #9. Coordinates: (0.43407, 0.16734)
# Point #10 is a target