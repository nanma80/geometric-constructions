# Try 3.5 5E
# After 4E we need to find the center of circle

require './geometric-constructions'

foot = Point.new([0, -1]).with_name('foot')
origin = Point.new([0, 0]).with_name('center of circle')

random_point_on_line = Point.new([-0.47, -1]).with_name('random point on horizontal')
horizontal = Line.new([foot, random_point_on_line])

random_angle = 135.7 * Math::PI / 180
random_point = Point.new([Math.cos(random_angle), Math.sin(random_angle)]).with_name('random point on circle')

initial_layout = Layout.new([foot, random_point, random_point_on_line], [horizontal], [])

targets = [origin]

# steps = [:circle, :circle, :circle, :circle]

# task = Task.new(initial_layout, targets, steps)

# solution_layout = task.solve
# solution_layout.print(targets)

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

  p [generator, steps]
  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve
  if not solution_layout.nil?
    p steps

    solution_layout.print(targets)
    exit
  end
end
