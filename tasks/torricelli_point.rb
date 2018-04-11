# 8.6 Torricelli Point 4L 5E

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

3.times do |index|
  p points[index]
end

step1 = Circle.new(points[1], points[2])

using_l_moves = true

initial_layout = Layout.new(points, sides, [])
initial_layout << step1

targets = [origin]

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

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
  p [generator, steps]

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve(subsample_rate: 0.5)

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end

# 5E
# *************Found solution*************
# [:circle, :line, :circle, :line]
# Layout has 18 points; 5 lines; 3 circles
# Point #0 is predefined. Coordinates: (-1.25747, -0.72600)
# Point #1 is predefined. Coordinates: (1.47917, -0.85400)
# Circle #2 is centered at Point #1 and passes Point #0. Center: (1.47917, -0.85400). Radius: 2.73963
# Circle #3 is predefined. Center: (-1.25747, -0.72600). Radius: 2.73963
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (-0.00000, -3.16000)
# Point #5 is predefined. Coordinates: (0.00000, 1.00000)
# Line #6 passes Point #4, Point #5. Norm direction: 0.00000. Distance to origin: 0.00000
# Point #7 is intersection of Line #6, Circle #2. Coordinates: (0.00000, 1.45200)
# Circle #8 is centered at Point #7 and passes Point #1. Center: (0.00000, 1.45200). Radius: 2.73963
# Point #9 is intersection of Circle #8, Circle #2. Coordinates: (2.73664, 1.58000)
# Line #10 passes Point #0, Point #9. Norm direction: 300.00000. Distance to origin: 0.00000
# Point #11 is intersection of Line #10, Line #6. Coordinates: (0.00000, 0.00000)
# Point #11 is a target

# 4L
# *************Found solution*************
# [:circle, :line, :angle_bis]
# Layout has 13 points; 5 lines; 2 circles
# Point #0 is predefined. Coordinates: (1.47917, -0.85400)
# Point #1 is predefined. Coordinates: (-1.25747, -0.72600)
# Point #2 is predefined. Coordinates: (0.00000, 1.00000)
# Circle #3 is centered at Point #0 and passes Point #1. Center: (1.47917, -0.85400). Radius: 2.73963
# Circle #4 is predefined. Center: (-1.25747, -0.72600). Radius: 2.73963
# Point #5 is intersection of Circle #3, Circle #4. Coordinates: (-0.00000, -3.16000)
# Line #6 passes Point #2, Point #5. Norm direction: 0.00000. Distance to origin: 0.00000
# Point #7 is intersection of Line #6, Circle #4. Coordinates: (0.00000, 1.70800)
# Line #8 is bisector of the angle specified by Point #0, Point #1, Point #7. Norm direction: 300.00000. Distance to origin: 0.00000
# Point #9 is intersection of Line #8, Line #6. Coordinates: (0.00000, 0.00000)
# Point #9 is a target