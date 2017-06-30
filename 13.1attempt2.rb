# New 13.1
# Assume the first 4 steps

require './geometric-constructions'

side = 1
left_side_angle = 34 * Math::PI / 180
triangle_bottom = 2.482

left_bottom = Point.new([0, 0]).with_name('left bottom')
right_bottom = Point.new([side, 0])
left_top = Point.new([side * Math.cos(left_side_angle), side * Math.sin(left_side_angle)])
right_top = Point.new([side + side * Math.cos(left_side_angle), side * Math.sin(left_side_angle)])

right_corner = Point.new([triangle_bottom, 0])
triangle_right_line = Line.new([right_corner, right_top])
triangle_left_line = Line.new([left_bottom, left_top])

down_line = LineSegment.new([left_bottom, right_corner]).with_name('down line')
top_point = triangle_left_line.intersection_with_line(triangle_right_line).first.with_name('top point')
left_line = LineSegment.new([left_bottom, top_point]).with_name('left line')
right_line = LineSegment.new([right_corner, top_point]).with_name('right_line')

para_up_line = Line.new([left_top, right_top])
other_line = Line.new([right_top, right_bottom])
# x = - 0.3
# random_down_point = Point.new([x, - 1])

step1_circle = Circle.new(left_bottom, top_point).with_name('step 1 circle')
down_intersection = step1_circle.intersection_with_line(down_line).first
step2_circle = Circle.new(down_intersection, top_point).with_name('step 2 circle')
step3_circle = Circle.new(top_point, down_intersection).with_name('step 3 circle')
step23_intersection = step2_circle.intersection_with_circle(step3_circle).sort_by { |point| point.x }.last
step4_line = Line.new([left_bottom, step23_intersection])


initial_layout = Layout.new(
  [top_point, left_bottom, right_corner], 
  [down_line, left_line, right_line], [])
initial_layout << step1_circle
initial_layout << step2_circle
initial_layout << step3_circle
initial_layout << step4_line

targets = [para_up_line]

# filters = {
#   4 => [right_top]
# }

# steps = [:circle, :circle, :line, :line,    :circle, :line]
steps = [:circle, :line, :line]
# steps = [:circle, :circle, :line, :line, :circle]


# task = Task.new(initial_layout, targets, steps)
# task.each_layout(print_interval: 100) do |layout|
#   layout.points.each do |point|
#     if (point.y - left_top.y).abs < EPSILON && (point.x - right_top.x).abs > EPSILON
#       puts "Found a solution"
#       layout.print([point])
#       exit
#     end
#   end
# end

task = Task.new(initial_layout, targets, steps)
solution_layout = task.solve
if solution_layout.nil?
else
  puts "\# *************Found solution*************"
  puts '# ' + steps.inspect
  solution_layout.print(targets)
  exit
end

