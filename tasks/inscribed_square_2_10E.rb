# 12.6 10E attempt

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

steps = [:circle, :circle, :line, :line, :circle, :circle]

task = Task.new(initial_layout, targets, steps, filters)
task.each_layout(print_interval: 100, subsample_rate: 0.15) do |layout|
  layout.points.each do |point|
    if (point.x - half_side).abs < EPSILON && (point.y - random_y).abs > EPSILON
      print "\a"
      puts "Found a solution"
      layout.print([point])
      exit
    end
  end
end

print "\a"
puts "No solution found"

# Layout has 21 points; 2 lines; 5 circles
# Point #0 is the given point. Coordinates: (1.00000, 0.72340)
# Point #1 is the center. Coordinates: (0.00000, 0.00000)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (1.00000, 0.72340). Radius: 1.23422
# Circle #3 is centered at Point #1 and passes Point #0. Center: (0.00000, 0.00000). Radius: 1.23422
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (-0.12648, 1.22773)
# Point #5 is intersection of Circle #2, Circle #3. Coordinates: (1.12648, -0.50433)
# Line #6 passes Point #4, Point #5. Norm direction: 35.88198. Distance to origin: 0.61711
# Line #7 passes Point #0, Point #1. Norm direction: 305.88198. Distance to origin: 0.00000
# Point #8 is intersection of Line #6, Line #7. Coordinates: (0.50000, 0.36170)
# Circle #9 is centered at Point #8 and passes Point #1. Center: (0.50000, 0.36170). Radius: 0.61711
# Point #10 is intersection of Line #6, Circle #9. Coordinates: (0.86170, -0.13830)
# Circle #11 is centered at Point #10 and passes Point #1. Center: (0.86170, -0.13830). Radius: 0.87273
# Circle #12 is the given circle. Center: (0.00000, 0.00000). Radius: 1.41421
# Point #13 is intersection of Circle #11, Circle #12. Coordinates: (1.00000, -1.00000)
# Point #13 is a target
