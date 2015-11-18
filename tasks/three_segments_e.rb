# three segments with E moves
require './geometric-constructions'

origin = Point.new([0, 0])
right_bottom = Point.new([1, 0])
theta_1 = 123 * Math::PI / 180
theta_2 = 34 * Math::PI / 180
middle_left_line = Point.new([Math.cos(theta_1), Math.sin(theta_1)])
top = Point.new([Math.cos(theta_1) + Math.cos(theta_2), Math.sin(theta_1) + Math.sin(theta_2)])

bottom_line = Line.new([origin, right_bottom])
left_line = Line.new([middle_left_line, top])
left_bottom = bottom_line.intersection_with_line(left_line).first

initial_layout = Layout.new([left_bottom, top, right_bottom], [left_line, bottom_line], [])

# targets = [Point.new([-0.5085100696026763, -2.4994068439781003])] # point from previous solution
targets = [origin]

step_count = 5
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

# Found a solution
# [:circle, :circle, :line, :circle, :line]
# Layout has 23 points; 4 lines; 3 circles
# Point #0 is predefined. Coordinates: (0.28439853754001454, 1.397863471416171)
# Point #1 is predefined. Coordinates: (1.0, 0.0)
# Line #2 passes Point #0, Point #1. Norm direction: 27.109048307724127. Distance to origin: 0.890140852600904
# Line #3 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #4 is predefined. Coordinates: (-1.788019284491324, 1.0948460467830204e-16)
# Circle #5 is centered at Point #4 and passes Point #0. Center: (-1.788019284491324, 1.0948460467830204e-16). Radius: 2.4997875737335735
# Point #6 is intersection of Line #3, Circle #5. Coordinates: (0.7117682892422494, -4.358323785775544e-17)
# Circle #7 is centered at Point #6 and passes Point #4. Center: (0.7117682892422494, -4.358323785775544e-17). Radius: 2.4997875737335735
# Point #8 is intersection of Line #2, Circle #7. Coordinates: (2.0732501811430586, -2.09649826420605)
# Circle #9 is centered at Point #8 and passes Point #6. Center: (2.0732501811430586, -2.09649826420605). Radius: 2.4997875737335735
# Point #10 is intersection of Circle #9, Circle #5. Coordinates: (-0.42653739259051493, -2.09649826420605)
# Line #11 passes Point #0, Point #10. Norm direction: 348.50000000000006. Distance to origin: 0.0
# Point #12 is intersection of Line #11, Line #3. Coordinates: (0.0, 0.0)
# Point #12 is a target
