# Trying 11.3 10E

require './geometric-constructions'

up_base = Point.new([0, 0])
ul_corner = Point.new([-1.32, 0])
ur_corner = Point.new([2.14, 0])
d_corner = Point.new([0, -1.7])
u_edge = Line.new([ul_corner, ur_corner])
l_edge = Line.new([ul_corner, d_corner])
r_edge = Line.new([ur_corner, d_corner])

ul_r_altitude = Line.perp(r_edge, ul_corner)
dr_base = ul_r_altitude.intersection_with_line(r_edge).first

ur_l_altitude = Line.perp(l_edge, ur_corner)
dl_base = ur_l_altitude.intersection_with_line(l_edge).first

p up_base.coordinates
p dr_base.coordinates
p dl_base.coordinates

up_center = Point.new([(ul_corner.x + ur_corner.x) / 2, 0])

initial_layout = Layout.new(
  [up_base, dr_base, dl_base],
  [],
  [])

targets = [up_center]
filters = {5 => [u_edge]}

moves = [:line, :circle]

step_count = 7
generator_max = moves.length ** step_count

(48..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end
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

# up_base [0.0, 0.0]
# dr_base [0.01867944735996463, -1.685161186676663]
# dl_base [-0.018578706502031306, -1.6760728779898093]
# *************Found solution*************
# [:line, :circle, :circle, :line, :line, :line, :line]
# Layout has 15 points; 5 lines; 2 circles
# Point #0 is predefined. Coordinates: (-0.01858, -1.67607)
# Point #1 is predefined. Coordinates: (0.00000, 0.00000)
# Line #2 passes Point #0, Point #1. Norm direction: 359.36492. Distance to origin: 0.00000
# Point #3 is predefined. Coordinates: (0.01868, -1.68516)
# Circle #4 is centered at Point #1 and passes Point #3. Center: (0.00000, 0.00000). Radius: 1.68526
# Point #5 is intersection of Line #2, Circle #4. Coordinates: (0.01868, 1.68516)
# Point #6 is intersection of Line #2, Circle #4. Coordinates: (-0.01868, -1.68516)
# Circle #7 is centered at Point #6 and passes Point #3. Center: (-0.01868, -1.68516). Radius: 0.03736
# Point #8 is intersection of Circle #7, Circle #4. Coordinates: (-0.05603, -1.68433)
# Line #9 passes Point #8, Point #0. Norm direction: 282.43819. Distance to origin: 1.63273
# Point #10 is intersection of Line #9, Circle #4. Coordinates: (0.75937, -1.50449)
# Line #11 passes Point #5, Point #10. Norm direction: 13.07327. Distance to origin: 0.39937
# Point #12 is intersection of Line #2, Circle #7. Coordinates: (-0.01827, -1.64780)
# Line #13 passes Point #12, Point #8. Norm direction: 314.04738. Distance to origin: 1.17169
# Point #14 is intersection of Line #13, Circle #4. Coordinates: (1.68526, 0.00000)
# Line #15 passes Point #1, Point #14. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #16 is intersection of Line #11, Line #15. Coordinates: (0.41000, 0.00000)
# Point #16 is a target
