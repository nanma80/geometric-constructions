# orthic triangle. 8E
# 

require './geometric-constructions'

left_down = Point.new([-1.0, 0])
right_down = Point.new([1.852, 0])
top = Point.new([0, 1.56])


horizontal = Line.new([left_down, right_down])
left_line = Line.new([left_down, top])
right_line = Line.new([right_down, top])

initial_layout = Layout.new([left_down, right_down, top], [horizontal, left_line, right_line], [])


down_foot = Line.perp(horizontal, top).intersection_with_line(horizontal).first
left_foot = Line.perp(left_line, right_down).intersection_with_line(left_line).first
right_foot = Line.perp(right_line, left_down).intersection_with_line(right_line).first

nine_point_circle_center = Line.perp_bis([down_foot, left_foot]).intersection_with_line(Line.perp_bis([down_foot, right_foot])).first

puts nine_point_circle_center.description


targets = [nine_point_circle_center]


step_count = 4
(0..(2**step_count - 1)).each do |generator|
  generator += 2 ** step_count
  generator_seq = generator.to_s(2)[1..-1].split('')

  steps = []
  generator_seq.each do |ch|
    if ch == '0'
      steps << :circle
    else
      steps << :line
    end
  end

  p [generator - 2 ** step_count, steps]
  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve
  if not solution_layout.nil?
    p steps

    solution_layout.print(targets)
    exit
  end
end
