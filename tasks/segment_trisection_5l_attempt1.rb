# Trying 9.6 Segment Trisection 5L
# Try to get one point in 4L
require './geometric-constructions'

left_point = Point.new([0, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')
horizontal_line = Line.new([left_point, right_point]).with_name('horizontal line')
left_node = Point.new([1.0/3.0, 0])
right_node = Point.new([2.0/3.0, 0])

circle = Circle.new(left_point, right_point).with_name('circle centered at the left point')

initial_layout = Layout.new([left_point, right_point], [horizontal_line], [circle])
targets = [left_node]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :compass]

step_count = 4
generator_max = l_moves.length ** step_count

(87..generator_max).each do |generator|
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
