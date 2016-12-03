# Trying 7.3 75 deg in 3L

require './geometric-constructions'

center_point = Point.new([0, 0])
right_point = Point.new([1, 0])
very_right_point = Point.new([10000000.0, 0])
# horizontal_line = LineSegment.new([center_point, very_right_point])
horizontal_line = Line.new([center_point, very_right_point])

up_distance = 2.23
theta = 75 * Math::PI / 180
up_point = Point.new([up_distance * Math.cos(theta), up_distance * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

random_point = Point.new([0.24, 1.13])
initial_layout = Layout.new([random_point, center_point, right_point], [horizontal_line], [])

targets = [line2]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
line_moves = [:line, :perp_bis, :perp, :parallel, :angle_bis]

step_count = 3
generator_max = l_moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  p [generator, steps]
  # next unless steps.include?(:angle_bis) # official tweet announced that we needed angle bis
  next unless line_moves.include?(steps.last)

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end

# *************Found solution*************
# [:circle, :circle, :angle_bis]
# Layout has 11 points; 2 lines; 2 circles
# Point #0 is predefined. Coordinates: (1.00000, 0.00000)
# Point #1 is predefined. Coordinates: (0.00000, 0.00000)
# Line #2 is predefined. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #3 is predefined. Coordinates: (0.24000, 1.13000)
# Circle #4 is centered at Point #3 and passes Point #1. Center: (0.24000, 1.13000). Radius: 1.15521
# Point #5 is intersection of Line #2, Circle #4. Coordinates: (0.48000, 0.00000)
# Circle #6 is centered at Point #5 and passes Point #3. Center: (0.48000, 0.00000). Radius: 1.15521
# Point #7 is intersection of Circle #6, Circle #4. Coordinates: (-0.61861, 0.35715)
# Line #8 is bisector of the angle specified by Point #0, Point #1, Point #7. Norm direction: 345.00000. Distance to origin: 0.00000
# Line #8 is a target