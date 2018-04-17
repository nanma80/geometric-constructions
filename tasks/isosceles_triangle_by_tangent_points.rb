# 3.10 7E

require './geometric-constructions'

origin = Point.new([0, 0])
bottom = Point.new([0, -1])
bottom2 = Point.new([1, -1])

theta = Math::PI / 180 * 58.2

tangent_point1 = Point.new([Math.cos(theta), Math.sin(theta)])
tangent_point2 = Point.new([-Math.cos(theta), Math.sin(theta)])
top = Point.new([0, 1.0 / Math.sin(theta)])

right_side = Line.new([top, tangent_point1])
left_side = Line.new([top, tangent_point2])
base = Line.new([bottom2, bottom])

right_bottom = base.intersection_with_line(right_side).first
left_bottom = base.intersection_with_line(left_side).first

circle = Circle.new(origin, bottom)

initial_layout = Layout.new([origin, bottom, tangent_point2], [], [circle])
targets = [left_side, base, right_side]
# filters = {4 => [left_side], 6 => [base]} # continue from 56
filters = {3 => [left_side], 5 => [right_side]} # found solution

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

moves = e_moves
step_count = 7

generator_max = moves.length ** step_count

(104..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
  next unless steps.last == :line
  p [generator, steps]

  task = Task.new(initial_layout, targets, steps, filters)

  solution_layout = task.solve

  if solution_layout.nil?
  else
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end

# *************Found solution*************
# [:circle, :circle, :line, :circle, :line, :line, :line]
# Layout has 21 points; 4 lines; 4 circles
# Point #0 is predefined. Coordinates: (-0.52696, 0.84989)
# Point #1 is predefined. Coordinates: (0.00000, -1.00000)
# Circle #2 is centered at Point #1 and passes Point #0. Center: (0.00000, -1.00000). Radius: 1.92348
# Circle #3 is predefined. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (0.52696, 0.84989)
# Circle #5 is centered at Point #0 and passes Point #4. Center: (-0.52696, 0.84989). Radius: 1.05391
# Point #6 is intersection of Circle #5, Circle #2. Coordinates: (-1.42267, 0.29453)
# Line #7 passes Point #6, Point #0. Norm direction: 121.80000. Distance to origin: 1.00000
# Line #7 is a target
# Point #8 is predefined. Coordinates: (0.00000, 0.00000)
# Circle #9 is centered at Point #8 and passes Point #6. Center: (0.00000, 0.00000). Radius: 1.45284
# Point #10 is intersection of Circle #9, Circle #2. Coordinates: (1.42267, 0.29453)
# Line #11 passes Point #10, Point #4. Norm direction: 58.20000. Distance to origin: 1.00000
# Point #12 is intersection of Line #11, Circle #9. Coordinates: (-0.36876, 1.40526)
# Line #13 passes Point #12, Point #0. Norm direction: 164.10000. Distance to origin: 0.73963
# Point #14 is intersection of Line #13, Circle #9. Coordinates: (-1.05391, -1.00000)
# Line #15 passes Point #1, Point #14. Norm direction: 270.00000. Distance to origin: 1.00000
# Line #15 is a target
# Line #16 passes Point #10, Point #4. Norm direction: 58.20000. Distance to origin: 1.00000
# Line #16 is a target
