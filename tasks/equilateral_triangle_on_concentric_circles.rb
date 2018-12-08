# 13.3 Equilateral triangle on concentric circles 8E

require './geometric-constructions'

origin = Point.new([0, 0]).with_name('origin')
r1 = 1.0
r2 = 2.379

circle1 = Circle.new(origin, Point.new([0, r1])).with_name('circle1')
circle2 = Circle.new(origin, Point.new([0, r2])).with_name('circle2')

point_right = Point.new([2.987, 0])

moved_circle1 = Circle.new(point_right, Point.new([point_right.x + r1, point_right.y]))
point_int = moved_circle1.intersection_with_circle(circle2).sort_by { |p| p.y }.first
pp point_int.coordinates

line_perp_bis = Line.perp_bis([point_int, origin])

point_int2 = line_perp_bis.intersection_with_circle(circle2).sort_by {|p| p.y}.first
pp point_int2.coordinates

initial_layout = Layout.new([origin, point_right], [], [circle1, circle2])

targets = [point_int2]

steps = [:circle] * 4

task = Task.new(initial_layout, targets, steps)
solution_layout = task.solve

if solution_layout.nil?
else
  puts "\# *************Found solution*************"
  puts '# ' + steps.inspect
  solution_layout.print(targets)
  exit
end

# *************Found solution*************
# [:circle, :circle, :circle, :circle]
# Layout has 19 points; 0 lines; 6 circles
# Point #0 is predefined. Coordinates: (2.98700, 0.00000)
# Point #1 is the origin. Coordinates: (0.00000, 0.00000)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (2.98700, 0.00000). Radius: 2.98700
# Circle #3 is centered at Point #1 and passes Point #0. Center: (0.00000, 0.00000). Radius: 2.98700
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (1.49350, -2.58682)
# Circle #5 is the circle1. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #6 is intersection of Circle #2, Circle #5. Coordinates: (0.16739, -0.98589)
# Circle #7 is centered at Point #6 and passes Point #0. Center: (0.16739, -0.98589). Radius: 2.98700
# Point #8 is intersection of Circle #7, Circle #2. Coordinates: (2.43100, -2.93480)
# Circle #9 is centered at Point #4 and passes Point #8. Center: (1.49350, -2.58682). Radius: 1.00000
# Circle #10 is the circle2. Center: (0.00000, 0.00000). Radius: 2.37900
# Point #11 is intersection of Circle #9, Circle #10. Coordinates: (0.52997, -2.31922)
# Point #11 is a target