# 13.2 circle tangent to two circles

require './geometric-constructions'

r1 = 1.73
r2 = 1.21
r0 = 1.0
theta2 = 56 * Math::PI / 180

origin = Point.new([0, 0]).with_name('origin')
left_center = Point.new([-(r1 + r0), 0]).with_name('left center')
up_center = Point.new([(r2 + r0) * Math.cos(theta2), (r2 + r0) * Math.sin(theta2)]).with_name('up center')

left_circle_right_point = Point.new([-(r0), 0]).with_name('left circle right point')
up_circle_right_point = Point.new([(r2 + r0) * Math.cos(theta2) + r2, (r2 + r0) * Math.sin(theta2)]).with_name('up circle right point')

left_circle = Circle.new(left_center, left_circle_right_point).with_name('left circle')
up_circle = Circle.new(up_center, up_circle_right_point).with_name('up circle')

horizontal_line = Line.new([origin, left_center]).with_name('horizontal line')

initial_layout = Layout.new([left_center, up_center], [], [left_circle, up_circle])
initial_layout << horizontal_line

raise unless initial_layout.contains?([left_circle_right_point])

targets = [up_circle_right_point]

step_count = 3
moves = [:circle, :line]
generator_max = moves.length ** step_count

filters = {}

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end

  p [generator, steps]

  layout = initial_layout.dup
  
  task = Task.new(layout, targets, steps, filters)

  solution_layout = task.solve(print_interval: 100, subsample_rate: 1.0)

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end

puts "No solution found"

# *************Found solution*************
# [:circle, :line, :circle]
# Layout has 18 points; 2 lines; 4 circles
# Line #0 is the horizontal line. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #1 is predefined. Coordinates: (-4.46000, 0.00000)
# Point #2 is the up center. Coordinates: (1.23582, 1.83217)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (-4.46000, 0.00000). Radius: 5.98324
# Point #4 is intersection of Line #0, Circle #3. Coordinates: (1.52324, -0.00000)
# Line #5 passes Point #2, Point #1. Norm direction: 107.83142. Distance to origin: 1.36573
# Circle #6 is the up circle. Center: (1.23582, 1.83217). Radius: 1.21000
# Point #7 is intersection of Line #5, Circle #6. Coordinates: (0.08394, 1.46165)
# Circle #8 is centered at Point #4 and passes Point #7. Center: (1.52324, -0.00000). Radius: 2.05134
# Point #9 is intersection of Circle #8, Circle #6. Coordinates: (2.44582, 1.83217)
# Point #9 is a target, the up circle right point
