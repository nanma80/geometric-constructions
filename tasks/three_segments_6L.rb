# 14.4 6L

require './geometric-constructions'

origin = Point.new([0, 0]).with_name('origin')
right_bottom = Point.new([1, 0]).with_name('right bottom')
theta_1 = 122.6 * Math::PI / 180
theta_2 = 34 * Math::PI / 180
middle_left_line = Point.new([Math.cos(theta_1), Math.sin(theta_1)])
top = Point.new([Math.cos(theta_1) + Math.cos(theta_2), Math.sin(theta_1) + Math.sin(theta_2)]).with_name('top')

bottom_line = Line.new([origin, right_bottom])
left_line = Line.new([middle_left_line, top])
left_bottom = bottom_line.intersection_with_line(left_line).first

bottom_line_segment = LineSegment.new([left_bottom, right_bottom]).with_name('bottom line segment')
left_line_segment = LineSegment.new([left_bottom, top]).with_name('left line segment')

initial_layout = Layout.new([left_bottom, top, right_bottom], [left_line_segment, bottom_line_segment], [])

targets = [origin]  # or middle_left_line

steps = [:compass, :circle, :parallel, :perp_bis]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve(subsample_rate: 1)

if solution_layout.nil?
else
  puts "*************Found solution*************"
  p steps
  solution_layout.print(targets)
  exit
end

# Layout has 18 points; 4 lines; 2 circles
# Point #0 is the right bottom. Coordinates: (1.00000, 0.00000)
# LineSegment #1 is the left line segment. Norm direction: 124.00000. Distance to origin: 0.99970
# LineSegment #2 is the bottom line segment. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #3 is the top. Coordinates: (0.29027, 1.40165)
# Point #4 is predefined. Coordinates: (-1.78776, 0.00000)
# Circle #5 is centered at Point #0 and radius is the distance between Point #3, Point #4. Center: (1.00000, 0.00000). Radius: 2.50655
# Point #6 is intersection of LineSegment #2, Circle #5. Coordinates: (-1.50655, 0.00000)
# Line #7 is parallel to LineSegment #1 and passes Point #6. Norm direction: 124.00000. Distance to origin: 0.84245
# Circle #8 is centered at Point #3 and passes Point #0. Center: (0.29027, 1.40165). Radius: 1.57109
# Point #9 is intersection of Line #7, Circle #8. Coordinates: (-0.91775, 0.39715)
# Line #10 is perpendicular bisector of Point #0, Point #9. Norm direction: 348.30000. Distance to origin: 0.00000
# Point #11 is intersection of Line #10, LineSegment #2. Coordinates: (0.00000, 0.00000)
# Point #11 is a target, the origin

