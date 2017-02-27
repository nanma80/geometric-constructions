# 8.8 5E attempt
# try to use 3E to get to p_cross2
# impossible without extra points.

require './geometric-constructions'

top_width = 1.115
bottom_width = 2.703
height = 1.832
left_shift = 0.84

mean_width = Math.sqrt(top_width * bottom_width)

ld_point = Point.new([0, 0]).with_name('left down')
rd_point = Point.new([bottom_width, 0]).with_name('right down')
lu_point = Point.new([left_shift, height]).with_name('left up')
ru_point = Point.new([left_shift + top_width, height]).with_name('right up')

top_line = LineSegment.new([lu_point, ru_point]).with_name('top line')
bottom_line = LineSegment.new([ld_point, rd_point]).with_name('bottom line')

left_line = LineSegment.new([lu_point, ld_point]).with_name('left line')
right_line = LineSegment.new([ru_point, rd_point]).with_name('right line')

cross_line1 = LineSegment.new([lu_point, rd_point]).with_name('lu rd cross line')
cross_line2 = LineSegment.new([ru_point, ld_point]).with_name('ru ld cross line')

random_point = Point.new([0.716, 0]).with_name('random point')
random_height = 0.718
random_horizontal_line = Line.new([Point.new([1, random_height]), Point.new([0, random_height])])

# initial_layout = Layout.new(
#   [ld_point, rd_point, lu_point, ru_point, random_point],
#   [top_line, bottom_line, left_line, right_line, cross_line1, cross_line2, random_horizontal_line], 
#   [])

initial_layout = Layout.new(
  [ld_point, rd_point, lu_point, ru_point, random_point],
  [top_line, bottom_line, left_line, right_line, cross_line1, cross_line2, random_horizontal_line], 
  [])

bottom_mid_point = Point.new([bottom_width / 2.0, 0])
target_height = Line.new([bottom_mid_point, lu_point]).intersection_with_line(cross_line2).first.y

target_line = Line.new([Point.new([1, target_height]), Point.new([0, target_height])])

p_left = left_line.intersection_with_line(target_line).first
p_cross1 = cross_line1.intersection_with_line(target_line).first
p_cross2 = cross_line2.intersection_with_line(target_line).first
p_right = right_line.intersection_with_line(target_line).first

puts p_cross2.x - p_left.x
puts p_cross1.x - p_cross2.x
puts p_right.x - p_cross1.x

top_mid_point = Point.new([ left_shift + top_width / 2.0, height])
target_height2 = Line.new([top_mid_point, ld_point]).intersection_with_line(cross_line1).first.y
target_line2 = Line.new([Point.new([1, target_height2]), Point.new([0, target_height2])])

p_left2 = left_line.intersection_with_line(target_line2).first
p_cross12 = cross_line1.intersection_with_line(target_line2).first
p_cross22 = cross_line2.intersection_with_line(target_line2).first
p_right2 = right_line.intersection_with_line(target_line2).first

puts p_cross12.x - p_left2.x
puts p_cross22.x - p_cross12.x
puts p_right2.x - p_cross22.x

targets = [p_left2]

filters = {}

step_count = 3
moves = [:line, :circle]
generator_max = moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end

  p [generator, steps]

  layout = initial_layout.dup
  
  task = Task.new(layout, targets, steps, filters)
  solution_layout = task.solve

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
  # task.each_layout(print_interval: 100, subsample_rate:1.0) do |solution_layout|
  #   if solution_layout.contains?(targets)
  #     puts "\# *************Found solution*************"
  #     puts '# ' + steps.inspect
  #     solution_layout.print(targets)
  #   end
  # end
end

puts "No solution found"
