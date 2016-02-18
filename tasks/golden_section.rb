# Trying 10.3 golden section
# New solution for 4L

require './geometric-constructions'

left_point = Point.new([0, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')
horizontal_line_segment = LineSegment.new([left_point, right_point]).with_name('horizontal line segment')
left_node = Point.new([(Math.sqrt(5.0)-1)/2, 0])

initial_layout = Layout.new([left_point, right_point], [horizontal_line_segment], [])
targets = [left_node]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]

step_count = 4
generator_max = l_moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
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
# [:circle, :circle, :perp_bis, :compass]
# Layout has 14 points; 2 lines; 3 circles
# LineSegment #0 is the horizontal line segment. Norm direction: 90.0. Distance to origin: 0.0
# Point #1 is the left point. Coordinates: (0.0, 0.0)
# Point #2 is the right point. Coordinates: (1.0, 0.0)
# Circle #3 is centered at Point #2 and passes Point #1. Center: (1.0, 0.0). Radius: 1.0
# Circle #4 is centered at Point #1 and passes Point #2. Center: (0.0, 0.0). Radius: 1.0
# Point #5 is intersection of Circle #3, Circle #4. Coordinates: (0.5, 0.8660254037844386)
# Line #6 is perpendicular bisector of Point #1, Point #5. Norm direction: 59.99999999999999. Distance to origin: 0.5
# Point #7 is intersection of Line #6, Circle #4. Coordinates: (-0.49999999999999983, 0.8660254037844387)
# Point #8 is intersection of Circle #3, Circle #4. Coordinates: (0.5, -0.8660254037844386)
# Point #9 is intersection of Line #6, Circle #3. Coordinates: (1.8660254037844384, -0.5000000000000002)
# Circle #10 is centered at Point #7 and radius is the distance between Point #8, Point #9. Center: (-0.49999999999999983, 0.8660254037844387). Radius: 1.4142135623730947
# Point #11 is intersection of LineSegment #0, Circle #10. Coordinates: (0.6180339887498947, -1.1102230246251565e-16)
# Point #11 is a target