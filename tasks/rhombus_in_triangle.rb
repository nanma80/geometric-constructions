# New 13.1

require './geometric-constructions'

side = 1
left_side_angle = 34 * Math::PI / 180
triangle_bottom = 2.682

left_bottom = Point.new([0, 0]).with_name('left bottom')
right_bottom = Point.new([side, 0])
left_top = Point.new([side * Math.cos(left_side_angle), side * Math.sin(left_side_angle)])
right_top = Point.new([side + side * Math.cos(left_side_angle), side * Math.sin(left_side_angle)])

right_corner = Point.new([triangle_bottom, 0]).with_name('right corner')
triangle_right_line = Line.new([right_corner, right_top])
triangle_left_line = Line.new([left_bottom, left_top])

down_line = LineSegment.new([left_bottom, right_corner]).with_name('down line')
top_point = triangle_left_line.intersection_with_line(triangle_right_line).first.with_name('top point')
left_line = LineSegment.new([left_bottom, top_point]).with_name('left line')
right_line = LineSegment.new([right_corner, top_point]).with_name('right_line')

left_side_length = left_bottom.distance_from(top_point)
right_side_length = right_corner.distance_from(top_point)
if left_side_length > right_side_length
  raise "The left side must be shorter than the right side"
end

para_up_line = Line.new([left_top, right_top])
other_line = Line.new([right_top, right_bottom])

initial_layout = Layout.new(
  [top_point, left_bottom, right_corner], 
  [down_line, left_line, right_line], [])
targets = [other_line]

filters = {
    4 => [right_top],
}

steps = [:circle, :circle, :line, :line,    :circle, :line]

task = Task.new(initial_layout, targets, steps, filters)
task.each_layout(print_interval: 100) do |layout|
  point1 = nil
  point2 = nil
  layout.points.each do |point|
    if point.on_line?(other_line) && (point.x - right_top.x).abs > EPSILON
      point2 = point
    end

    if (point.y - left_top.y).abs < EPSILON && (point.x - right_top.x).abs > EPSILON
      point1 = point
    end

    if !point1.nil? && !point2.nil?
      puts "Found a solution"
      layout.print([point1, point2])
      exit
    end
  end
end

# Layout has 16 points; 6 lines; 3 circles
# LineSegment #0 is the right_line. Norm direction: 56.75159. Distance to origin: 1.47046
# Point #1 is the top point. Coordinates: (1.32193, 0.89165)
# Point #2 is the left bottom. Coordinates: (0.00000, 0.00000)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (1.32193, 0.89165). Radius: 1.59453
# Point #4 is intersection of LineSegment #0, Circle #3. Coordinates: (2.65543, 0.01742)
# LineSegment #5 is the down line. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #6 is the right corner. Coordinates: (2.68200, 0.00000)
# Circle #7 is centered at Point #6 and passes Point #4. Center: (2.68200, 0.00000). Radius: 0.03177
# Point #8 is intersection of LineSegment #5, Circle #7. Coordinates: (2.65023, -0.00000)
# Line #9 passes Point #4, Point #8. Norm direction: 343.37579. Distance to origin: 2.53946
# Point #10 is intersection of Line #9, Circle #3. Coordinates: (2.91646, 0.89165)
# Line #11 passes Point #2, Point #10. Norm direction: 287.00000. Distance to origin: 0.00000
# Point #12 is intersection of Line #11, LineSegment #0. Coordinates: (1.82904, 0.55919)
# Circle #13 is centered at Point #12 and passes Point #4. Center: (1.82904, 0.55919). Radius: 0.98816
# Point #14 is intersection of Line #9, Circle #13. Coordinates: (2.81719, 0.55919)
# Point #14 is a target
# Line #15 passes Point #2, Point #4. Norm direction: 270.37579. Distance to origin: 0.00000
# Point #16 is intersection of Line #15, Circle #13. Coordinates: (1.00982, 0.00662)
# Point #16 is a target
