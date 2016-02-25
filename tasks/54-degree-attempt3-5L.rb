# Trying 10.4 54 deg in 5L
# add the golden ratio point as a filter
# stopped in the middle of 7190. Processed 24100/35200 layouts in this round

require './geometric-constructions'

center_point = Point.new([0, 0])
right_point = Point.new([1, 0])
very_right_point = Point.new([10000000.0, 0])
horizontal_line = LineSegment.new([center_point, very_right_point])

up_distance = 2.23
theta = 54 * Math::PI / 180
up_point = Point.new([up_distance * Math.cos(theta), up_distance * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

initial_layout = Layout.new([center_point, right_point], [horizontal_line], [])
initial_layout << Line.new([Point.new([0.5, 0]), Point.new([0.5, 1])])
initial_layout << Circle.new(Point.new([0.5, 0]), Point.new([0.5, 1]))
initial_layout << Circle.new(Point.new([1.5, 0]), Point.new([1.5 - Math.sqrt(5) * 0.5, 0]))

filters = {
}
targets = [line2]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
line_moves = [:line, :perp_bis, :perp, :parallel, :angle_bis]

step_count = 2
generator_max = l_moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  Logger.log [generator, steps].inspect
  # next unless steps.include?(:angle_bis) # official tweet announced that we needed angle bis
  next unless line_moves.include?(steps.last)

  task = Task.new(initial_layout, targets, steps, filters)

  solution_layout = task.solve

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end
