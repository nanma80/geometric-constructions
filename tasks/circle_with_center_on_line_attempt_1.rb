# 13.9 in 7L  attempt
require './geometric-constructions'

arbitrary_x = - 0.71
target_center = Point.new([0, 0]).with_name('target center')
point_horizontal_line = Point.new([arbitrary_x, 0]).with_name('random point on horizontal line')
horizontal_line = Line.new([target_center, point_horizontal_line]).with_name('horizontal line')

target_radius = 2.13
radius_given_circle = 1.0
theta_given_circle = 129 * Math::PI / 180
theta_given_point = 26 * Math::PI / 180

distance_given_circle = target_radius + radius_given_circle
center_given_circle = Point.new([distance_given_circle * Math.cos(theta_given_circle), distance_given_circle * Math.sin(theta_given_circle)]).with_name('center of given circle')

target_tangent_point = Point.new([radius_given_circle * Math.cos(theta_given_circle), radius_given_circle * Math.sin(theta_given_circle)]).with_name('tangent point')
given_circle = Circle.new(center_given_circle, target_tangent_point)

given_point = Point.new([radius_given_circle * Math.cos(theta_given_point), radius_given_circle * Math.sin(theta_given_point)]).with_name('given point')

initial_layout = Layout.new([point_horizontal_line, center_given_circle, given_point], [horizontal_line], [given_circle])

# step 1 in 8L
perp_line = Line.perp(horizontal_line, given_point)
initial_layout << perp_line

# step 2 in 8L
circle_step_2 = Circle.new(point_horizontal_line, given_point)
initial_layout << circle_step_2

# step 3 in 8L
circle_intersections = circle_step_2.intersection_with_circle(given_circle)
raise 'Two circles do not intersect' if circle_intersections.empty?

line_step_3 = Line.new(circle_intersections)
initial_layout << line_step_3

pole = line_step_3.intersection_with_line(perp_line).first

# step 4 in 8L
midpoint_line = Line.new([center_given_circle, pole])
# initial_layout << midpoint_line

# step 5 in 8L
midpoint_perp_bis = Line.perp_bis([center_given_circle, pole])
# initial_layout << midpoint_perp_bis

midpoint = midpoint_line.intersection_with_line(midpoint_perp_bis).first

# step 6 in 8L
circle_step_6 = Circle.new(midpoint, center_given_circle)
# initial_layout << circle_step_6
constructed_tangent_point = circle_step_6.intersection_with_circle(given_circle).sort_by { |point| point.y }.first
# puts constructed_tangent_point == target_tangent_point  # true

# step 7 in 8L
ray = Line.new([center_given_circle, constructed_tangent_point])
# initial_layout << ray
constructed_target_center = ray.intersection_with_line(horizontal_line).first
# puts constructed_target_center == target_center # true

# puts initial_layout.contains?([target_center]) # true

targets = [target_tangent_point]
l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]

step_count = 2
generator_max = l_moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  p [generator, steps]
  next unless steps.count(:compass) >= 1

  layout = initial_layout.dup

  task = Task.new(layout, targets, steps)

  solution_layout = task.solve(print_interval: 1)

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end

  puts "No solution found"
end

