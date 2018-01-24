# 14.4 6L attempt
# Attempt 0: assume step1 = Line.new([right_bottom, top]) and search for 4 steps (mistake)
# Didn't find anything until 419
# Attempt 1: Failed. assume step1 = Line.new([right_bottom, top]) 
# and the last two steps are a circle to find the other point and connecting them
# Failed in two ways
# Attempt 2: don't assume first step. Search for 4 steps. Searched up to 97
# Attempt 3: assume step1 = Circle.new(left_bottom, top). Search for 3 steps. 
# Didn't find anything with target = origin (0.3 sample rate)
# for target = middle_left_line, didn't find anything


require './geometric-constructions'

origin = Point.new([0, 0]).with_name('origin')
right_bottom = Point.new([1, 0]).with_name('right bottom')
theta_1 = 122.6 * Math::PI / 180
theta_2 = 34 * Math::PI / 180
middle_left_line = Point.new([Math.cos(theta_1), Math.sin(theta_1)])
top = Point.new([Math.cos(theta_1) + Math.cos(theta_2), Math.sin(theta_1) + Math.sin(theta_2)]).with_name('top')

bottom_line = Line.new([origin, right_bottom])
left_line = Line.new([middle_left_line, top])
left_bottom = bottom_line.intersection_with_line(left_line).first

bottom_line_segment = LineSegment.new([left_bottom, right_bottom]).with_name('bottom line segment')
left_line_segment = LineSegment.new([left_bottom, top]).with_name('left line segment')

initial_layout = Layout.new([left_bottom, top, right_bottom], [left_line_segment, bottom_line_segment], [])

# step1 = Circle.new(left_bottom, top)
# new_point = step1.intersection_with_line(bottom_line_segment).first
# p left_bottom.coordinates
# p new_point.coordinates

# initial_layout << step1

targets = [origin]  # or middle_left_line
# targets = [middle_left_line]

l_moves = [:line, :circle, :perp_bis, :perp, :parallel, :angle_bis, :compass] # up to 97

step_count = 4
generator_max = l_moves.length ** step_count

(61..generator_max).each do |generator|
# (188..200).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  p [generator, steps]

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve(subsample_rate: 1)

  if solution_layout.nil?
  else
    puts "*************Found solution*************"
    p steps
    solution_layout.print(targets)
    exit
  end
end
