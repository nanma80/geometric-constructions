# Trying 10.4 54 deg in 5L
# This one should work

require './geometric-constructions'

center_point = Point.new([0, 0]).with_name("vertex of ray")
right_point = Point.new([1, 0]).with_name("arbitrary point on ray")
very_right_point = Point.new([10000000.0, 0])
horizontal_line = LineSegment.new([center_point, very_right_point]).with_name("ray")

up_distance = 2.23
theta = 54 * Math::PI / 180
up_point = Point.new([up_distance * Math.cos(theta), up_distance * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

initial_layout = Layout.new([center_point, right_point], [horizontal_line], [])
initial_layout << Line.new([Point.new([0.5, 0]), Point.new([0.5, 1])]).with_name("perp bis") # :perp_bis
initial_layout << Circle.new(Point.new([0.5, 0]), Point.new([0.5, 1])).with_name("compass 1") # :compass
initial_layout << Circle.new(Point.new([0.5, 1]), Point.new([2, 1])).with_name("compass 2") # :compass

targets = [line2]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
line_moves = [:line, :perp_bis, :perp, :parallel, :angle_bis]

steps = [:compass, :angle_bis]

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
# [:compass, :angle_bis]
# Layout has 23 points; 3 lines; 3 circles
# Line #0 is the perp bis. Norm direction: 0.0. Distance to origin: 0.5
# Point #1 is the arbitrary point on ray. Coordinates: (1.0, 0.0)
# Point #2 is predefined. Coordinates: (1.618033988749895, 0.0)
# Point #3 is the vertex of ray. Coordinates: (0.0, 0.0)
# Circle #4 is centered at Point #1 and radius is the distance between Point #2, Point #3. Center: (1.0, 0.0). Radius: 1.618033988749895
# Point #5 is intersection of Line #0, Circle #4. Coordinates: (0.5, -1.5388417685876268)
# Circle #6 is the compass 2. Center: (0.5, 1.0). Radius: 1.5
# Point #7 is intersection of Circle #4, Circle #6. Coordinates: (-0.6180339887498949, 0.0)
# Line #8 is bisector of the angle specified by Point #5, Point #3, Point #7. Norm direction: 324.0. Distance to origin: 0.0
# Line #8 is a target
