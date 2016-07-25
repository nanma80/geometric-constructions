# 12.1 in 8E attempt

require './geometric-constructions'

arbitrary_x = - 0.71
target_radius = 1.13
radius_given_circle = 1.0
theta_given_circle = 129 * Math::PI / 180

target_center = Point.new([0, 0]).with_name('target center')
bottom_given_circle = Point.new([0, - target_radius]).with_name('bottom point of given circle')
point_horizontal_line = Point.new([arbitrary_x, - target_radius]).with_name('random point on horizontal line')
horizontal_line = Line.new([bottom_given_circle, point_horizontal_line]).with_name('horizontal line')

distance_given_circle = target_radius + radius_given_circle
center_given_circle = Point.new([distance_given_circle * Math.cos(theta_given_circle), distance_given_circle * Math.sin(theta_given_circle)]).with_name('center of given circle')

target_tangent_point = Point.new([target_radius * Math.cos(theta_given_circle), target_radius * Math.sin(theta_given_circle)]).with_name('two circle tangent point')

given_circle = Circle.new(center_given_circle, target_tangent_point)


initial_layout = Layout.new([bottom_given_circle, center_given_circle], [horizontal_line], [given_circle])

# Given perp
step_1_circle = Circle.new(center_given_circle, bottom_given_circle)
new_point_horizontal_line = step_1_circle.intersection_with_line(horizontal_line).sort_by { |point| point.x }.first
step_2_line = Line.new([new_point_horizontal_line, center_given_circle])
up_point = step_1_circle.intersection_with_line(step_2_line).sort_by { |point| point.x }.last
step_3_line = Line.new([up_point, bottom_given_circle])

initial_layout << step_1_circle
initial_layout << step_2_line
initial_layout << step_3_line

targets = [target_tangent_point]

step_count = 3
moves = [:circle, :line]
generator_max = moves.length ** step_count

(1..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
  p [generator, steps]

  layout = initial_layout.dup

  task = Task.new(layout, targets, steps)

  solution_layout = task.solve(print_interval: 100)

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end

  puts "No solution found"
end

# *************Found solution*************
# [:circle, :circle, :line]
# Layout has 20 points; 4 lines; 4 circles
# Point #0 is predefined. Coordinates: (-1.77410, 0.75424)
# Line #1 is predefined. Norm direction: 0.00000. Distance to origin: 0.00000
# Point #2 is the center of given circle. Coordinates: (-1.34045, 1.65532)
# Point #3 is predefined. Coordinates: (0.00000, 4.44064)
# Point #4 is predefined. Coordinates: (-0.90680, 2.55640)
# Circle #5 is centered at Point #3 and passes Point #4. Center: (0.00000, 4.44064). Radius: 2.09109
# Point #6 is intersection of Line #1, Circle #5. Coordinates: (0.00000, 2.34955)
# Circle #7 is centered at Point #2 and passes Point #6. Center: (-1.34045, 1.65532). Radius: 1.50956
# Point #8 is intersection of Line #1, Circle #7. Coordinates: (0.00000, 0.96109)
# Line #9 passes Point #0, Point #8. Norm direction: 96.65027. Distance to origin: 0.95462
# Circle #10 is predefined. Center: (-1.34045, 1.65532). Radius: 1.00000
# Point #11 is intersection of Line #9, Circle #10. Coordinates: (-0.71113, 0.87817)
# Point #11 is a target, the two circle tangent point
