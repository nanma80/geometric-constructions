# 6.10 symmetry of four lines 4E

require './geometric-constructions'

origin = Point.new([0, 0])
thetas = [Math::PI / 180 * 23.13, - Math::PI / 180 * 23.13, Math::PI / 180 * 106.41, -Math::PI / 180 * 106.41]
distances = [1.0, 1.7382, 1.0, 1.0]

points = []
lines = []
4.times do |index|
  points << Point.new([distances[index] * Math.cos(thetas[index]), distances[index] * Math.sin(thetas[index])])
  lines << Line.new([origin, points[index]]).with_name('line no. ' + index.to_s)
end

4.times do |index|
  p lines[index]
end

using_l_moves = false

initial_layout = Layout.new([origin, points[0]], [lines[0], lines[1], lines[2]], [])

targets = [lines[3]]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

if using_l_moves
  moves = l_moves
  step_count = 3
else
  moves = e_moves
  step_count = 4
end

generator_max = moves.length ** step_count

(10..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
  p [generator, steps]

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve(subsample_rate: 1.0)

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end

# *************Found solution*************
# [:circle, :line, :circle, :line]
# Layout has 17 points; 5 lines; 2 circles
# Point #0 is predefined. Coordinates: (0.00000, 0.00000)
# Point #1 is predefined. Coordinates: (0.91962, 0.39282)
# Line #2 is the line no. 1. Norm direction: 66.87000. Distance to origin: 0.00000
# Circle #3 is centered at Point #0 and passes Point #1. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #4 is intersection of Line #2, Circle #3. Coordinates: (-0.91962, 0.39282)
# Line #5 passes Point #1, Point #4. Norm direction: 90.00000. Distance to origin: 0.39282
# Line #6 is the line no. 2. Norm direction: 16.41000. Distance to origin: 0.00000
# Point #7 is intersection of Line #5, Line #6. Coordinates: (-0.11569, 0.39282)
# Circle #8 is centered at Point #0 and passes Point #7. Center: (0.00000, 0.00000). Radius: 0.40950
# Point #9 is intersection of Line #5, Circle #8. Coordinates: (0.11569, 0.39282)
# Line #10 passes Point #0, Point #9. Norm direction: 343.59000. Distance to origin: 0.00000
# Line #10 is a target, the line no. 3