# 8.6 Torricelli Point 4L

require './geometric-constructions'

origin = Point.new([0, 0])
thetas = [Math::PI / 2, Math::PI / 2 + 2 * Math::PI / 3, Math::PI / 2 - 2 * Math::PI / 3]
distances = [1.0, 1.452, 1.708]

points = []
3.times do |index|
  points << Point.new([distances[index] * Math.cos(thetas[index]), distances[index] * Math.sin(thetas[index])])
end

sides = []
3.times do |index|
  sides << LineSegment.new([points[index], points[(index + 1) % 3]])
end

using_l_moves = false

initial_layout = Layout.new(points, sides, [])
targets = [origin]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

if using_l_moves
  moves = l_moves
  step_count = 4
else
  moves = e_moves
  step_count = 5
end

generator_max = moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
  p [generator, steps]

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end
