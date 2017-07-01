# 12.6 7L attempt

require './geometric-constructions'

half_side = 1.0
radius = half_side * Math.sqrt(2.0)
random_y = 0.7234

center = Point.new([0, 0]).with_name('center')
circle = Circle.new(center, Point.new([radius, 0])).with_name('given circle')
given_point = Point.new([half_side, random_y]).with_name('given point')

right_line = Line.new([Point.new([half_side, 0]), given_point])


initial_layout = Layout.new(
  [center, given_point],
  [], 
  [circle])

targets = [right_line]

filters = {}

steps = [:circle, :line, :angle_bis, :angle_bis]

task = Task.new(initial_layout, targets, steps)
solution_layout = task.solve
if solution_layout.nil?
else
  puts "\# *************Found solution*************"
  puts '# ' + steps.inspect
  solution_layout.print(targets)
  exit
end

puts "No solution found"

# *************Found solution*************
# [:circle, :line, :angle_bis, :angle_bis]
# Layout has 14 points; 3 lines; 2 circles
# Point #0 is the given point. Coordinates: (1.00000, 0.72340)
# Point #1 is the center. Coordinates: (0.00000, 0.00000)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (1.00000, 0.72340). Radius: 1.23422
# Circle #3 is the given circle. Center: (0.00000, 0.00000). Radius: 1.41421
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (-0.02291, 1.41403)
# Point #5 is intersection of Circle #2, Circle #3. Coordinates: (1.33584, -0.46425)
# Line #6 passes Point #5, Point #0. Norm direction: 15.78966. Distance to origin: 1.15911
# Point #7 is intersection of Line #6, Circle #3. Coordinates: (0.89490, 1.09506)
# Line #8 is bisector of the angle specified by Point #1, Point #7, Point #4. Norm direction: 105.78966. Distance to origin: 0.81023
# Point #9 is intersection of Line #8, Circle #2. Coordinates: (2.02291, 1.41403)
# Line #10 is bisector of the angle specified by Point #4, Point #0, Point #9. Norm direction: 0.00000. Distance to origin: 1.00000
# Line #10 is a target
