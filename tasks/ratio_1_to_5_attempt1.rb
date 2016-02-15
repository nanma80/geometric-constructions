# Trying 9.9 Ratio 1 to 5 4L
# Before implementing angle bisector
# If one of the steps is the circle, with 3 other moves, no solution
# Tried all 4 moves, no solution consistent with the fact that the horizontal line is actually only a line segment.
require './geometric-constructions'

left_point = Point.new([0, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')
horizontal_line = Line.new([left_point, right_point]).with_name('horizontal line')
left_node = Point.new([1.0/6.0, 0])

circle = Circle.new(left_point, right_point).with_name('circle centered at the left point')

initial_layout = Layout.new([left_point, right_point], [horizontal_line], [circle])
targets = [left_node]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]

step_count = 3
generator_max = l_moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  p [generator, steps]

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve

  if solution_layout.nil?
  else
    puts "*************Found solution*************"
    p steps
    solution_layout.print(targets)
    # exit
  end
end
