# Trying 10.9 3-degree for 7E
# What we have learned:
# 7E not possible if we follow old path (54 deg) until finishing golden circle
# 7E unlikely (20% checked) if we follow old path (54 deg) until finishing connecting line

require './geometric-constructions'

center_point = Point.new([0, 0]).with_name("vertex of ray")
right_point = Point.new([1, 0]).with_name("arbitrary point on ray")
very_right_point = Point.new([10000000.0, 0])
horizontal_line = LineSegment.new([center_point, very_right_point]).with_name("ray")

up_distance = 2.23
theta = 3 * Math::PI / 180
up_point = Point.new([up_distance * Math.cos(theta), up_distance * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

right_circle = Circle.new(right_point, center_point).with_name('right circle')
left_circle = Circle.new(center_point, right_point).with_name('left circle')
big_right_circle = Circle.new(Point.new([2, 0]), center_point).with_name('big right circle')

up_intersection = left_circle.intersection_with_circle(right_circle).select{|p| p.y > 0}.first
down_intersection = left_circle.intersection_with_circle(big_right_circle).select{|p| p.y < 0}.first
connecting_line = Line.new([up_intersection, down_intersection]).with_name('line connecting intersections')
golden_point = connecting_line.intersection_with_line(horizontal_line).first
golden_circle = Circle.new(Point.new([2, 0]), golden_point).with_name('golden circle')

initial_layout = Layout.new([center_point, right_point], [horizontal_line], [])
initial_layout << right_circle
initial_layout << left_circle
initial_layout << big_right_circle
initial_layout << connecting_line
# initial_layout << golden_circle

targets = [line2]

moves = [:circle, :line]
filters = {}

step_count = 3
generator_max = moves.length ** step_count

(2..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
  Logger.log "\e[33m#{[generator, steps].inspect}\e[0m"
  next unless steps.last == :line

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
