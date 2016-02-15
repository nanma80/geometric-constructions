# Trying 9.9 Ratio 1 to 5 4L
# Use line segment

require './geometric-constructions'

left_point = Point.new([0, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')
horizontal_line_segment = LineSegment.new([left_point, right_point]).with_name('horizontal line segment')
left_node = Point.new([1.0/6.0, 0])

initial_layout = Layout.new([left_point, right_point], [horizontal_line_segment], [])
targets = [left_node]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]

step_count = 4
generator_max = l_moves.length ** step_count

(992..(generator_max - 1)).each do |generator|
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
    puts "\# *************Found solution*************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    exit
  end
end

# Found a solution
# *************Found solution*************
# [:perp_bis, :compass, :line, :angle_bis]
# Layout has 9 points; 4 lines; 1 circles
# Point #0 is the right point. Coordinates: (1.0, 0.0)
# Point #1 is the left point. Coordinates: (0.0, 0.0)
# Line #2 is perpendicular bisector of Point #1, Point #0. Norm direction: 0.0. Distance to origin: 0.5
# LineSegment #3 is the horizontal line segment. Norm direction: 90.0. Distance to origin: 0.0
# Point #4 is intersection of Line #2, LineSegment #3. Coordinates: (0.5, -3.061616997868383e-17)
# Circle #5 is centered at Point #4 and radius is the distance between Point #1, Point #0. Center: (0.5, -3.061616997868383e-17). Radius: 1.0
# Point #6 is intersection of Line #2, Circle #5. Coordinates: (0.5, 1.0)
# Point #7 is intersection of Line #2, Circle #5. Coordinates: (0.5, -1.0)
# Line #8 passes Point #1, Point #7. Norm direction: 26.56505117707799. Distance to origin: 0.0
# Point #9 is intersection of Line #8, Circle #5. Coordinates: (-0.30000000000000004, 0.5999999999999999)
# Line #10 is bisector of the angle specified by Point #0, Point #6, Point #9. Norm direction: 341.56505117707803. Distance to origin: 0.15811388300841905
# Point #11 is intersection of Line #10, LineSegment #3. Coordinates: (0.1666666666666667, -1.0205389992894611e-17)
# Point #11 is a target
