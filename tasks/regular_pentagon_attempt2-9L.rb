# regular pentagon
# We learned that it's impossible to establish a circle in 4L that is centered at (0, -1) and passing bottom_point
# We learned that it's impossible to establish up_right vertex in 4L
# Solution not found. But we already got a 9L solution with help from wechat.

require './geometric-constructions'

origin = Point.new([0, 0]).with_name('center of circle')
top_point = Point.new([0, 1]).with_name('top point')
circle = Circle.new(origin, top_point).with_name('given circle')

theta = 360 / 5 * Math::PI / 180

up_right = Point.new([Math.sin(theta), Math.cos(theta)]).with_name('up right point')
down_right = Point.new([Math.sin(2*theta), Math.cos(2*theta)]).with_name('down right point')

# bottom_point = Line.new([origin, top_point]).intersection_with_line(Line.new([up_right, down_right])).first
# target_circle_center = Point.new([0, -1])
# target_circle = Circle.new(target_circle_center, bottom_point)
filters = {}

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
line_moves = [:line, :perp_bis, :perp, :parallel, :angle_bis]
circle_moves = [:circle, :compass]

step_count = 2
generator_max = l_moves.length ** step_count

initial_layout = Layout.new([origin, top_point], [], [circle])
initial_layout << Line.new([origin, top_point])
initial_layout << Line.new([Point.new([0, -0.5]), Point.new([1, -0.5])]).with_name('perp bis')
initial_layout << Circle.new(Point.new([0, -0.5]), Point.new([1, -0.5])).with_name('compass 1')

targets = [Line.new([top_point, up_right])]

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  Logger.log "\e[33m#{[generator, steps].inspect}\e[0m"
  # next unless steps.include?(:angle_bis)
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
