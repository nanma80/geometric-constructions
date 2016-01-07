# 12.7 Triangle by tangent point on hypotenuse
require './geometric-constructions'

left_point = Point.new([-1, 0])
right_point = Point.new([1, 0])
horizontal_line = Line.new([left_point, right_point])

double_theta = 74 * Math::PI / 180
theta = double_theta / 2.0
x = Math.sqrt(2) * Math.sin(Math::PI / 4.0 - theta)

foot_point = Point.new([x, 0])

up_point = Point.new([Math.cos(double_theta), Math.sin(double_theta)])

initial_layout = Layout.new([foot_point, left_point, right_point], [horizontal_line], [])
targets = [up_point]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :compass]

step_count = 4
generator_max = l_moves.length ** step_count

(432..generator_max).each do |generator|
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
    exit
  end
end


# steps = [:perp_bis, :circle, :circle, :line, :circle]

# task = Task.new(initial_layout, targets, steps)

# solution_layout = task.solve

# solution_layout.print(targets)

# Found a solution
# *************Found solution*************
# 437
# [:perp_bis, :circle, :circle, :compass]
# Layout has 13 points; 2 lines; 3 circles
# Point #0 is predefined. Coordinates: (1.0, 0.0)
# Point #1 is predefined. Coordinates: (-1.0, 0.0)
# Line #2 is perpendicular bisector of Point #0, Point #1. Norm direction: 0.0. Distance to origin: 0.0
# Line #3 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #4 is intersection of Line #2, Line #3. Coordinates: (-0.0, 0.0)
# Circle #5 is centered at Point #4 and passes Point #1. Center: (-0.0, 0.0). Radius: 1.0
# Point #6 is intersection of Line #2, Circle #5. Coordinates: (0.0, 1.0)
# Point #7 is predefined. Coordinates: (0.19682048689524453, 0.0)
# Circle #8 is centered at Point #4 and passes Point #7. Center: (-0.0, 0.0). Radius: 0.19682048689524453
# Point #9 is intersection of Line #2, Circle #8. Coordinates: (0.0, -0.19682048689524453)
# Circle #10 is centered at Point #6 and radius is the distance between Point #7, Point #9. Center: (0.0, 1.0). Radius: 0.2783462019201308
# Point #11 is intersection of Circle #10, Circle #5. Coordinates: (0.2756373558169991, 0.9612616959383189)
# Point #11 is a target
