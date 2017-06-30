# New 13.1

require './geometric-constructions'

side = 1
left_side_angle = 34 * Math::PI / 180
triangle_bottom = 2.482

left_bottom = Point.new([0, 0])
right_bottom = Point.new([side, 0])
left_top = Point.new([side * Math.cos(left_side_angle), side * Math.sin(left_side_angle)])
right_top = Point.new([side + side * Math.cos(left_side_angle), side * Math.sin(left_side_angle)])

right_corner = Point.new([triangle_bottom, 0])
triangle_right_line = Line.new([right_corner, right_top])
triangle_left_line = Line.new([left_bottom, left_top])

down_line = LineSegment.new([left_bottom, right_corner])
top_point = triangle_left_line.intersection_with_line(triangle_right_line).first
left_line = LineSegment.new([left_bottom, top_point])
right_line = LineSegment.new([right_corner, top_point])

para_up_line = Line.new([left_top, right_top])
# x = - 0.3
# random_down_point = Point.new([x, - 1])

initial_layout = Layout.new(
  [top_point, left_bottom, right_corner], 
  [down_line, left_line, right_line], [])
targets = [right_top]

filters = {
  4 => [right_top]
}

# steps = [:circle, :circle, :line, :line,    :circle, :line]
steps = [:circle, :circle, :circle, :line,    :circle, :line]
# steps = [:circle, :circle, :line, :line, :circle]


task = Task.new(initial_layout, targets, steps, filters)
task.each_layout(print_interval: 100) do |layout|
  layout.points.each do |point|
    if (point.y - left_top.y).abs < EPSILON && (point.x - right_top.x).abs > EPSILON
      puts "Found a solution"
      layout.print([point])
      exit
    end
  end
end

# task = Task.new(initial_layout, targets, steps)
# solution_layout = task.solve
# if solution_layout.nil?
# else
#   puts "\# *************Found solution*************"
#   puts '# ' + steps.inspect
#   solution_layout.print(targets)
#   exit
# end

# Layout has 28 points; 5 lines; 4 circles
# LineSegment #0 is predefined. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #1 is predefined. Coordinates: (1.78200, 0.00000)
# LineSegment #2 is predefined. Norm direction: 304.00000. Distance to origin: 0.00000
# Point #3 is predefined. Coordinates: (0.00000, 0.00000)
# Circle #4 is centered at Point #3 and passes Point #1. Center: (0.00000, 0.00000). Radius: 1.78200
# Point #5 is intersection of LineSegment #2, Circle #4. Coordinates: (1.47734, 0.99648)
# Circle #6 is centered at Point #1 and passes Point #5. Center: (1.78200, 0.00000). Radius: 1.04201
# Point #7 is intersection of LineSegment #0, Circle #6. Coordinates: (0.73999, -0.00000)
# LineSegment #8 is predefined. Norm direction: 355.19178. Distance to origin: 1.77573
# Point #9 is intersection of LineSegment #8, Circle #6. Coordinates: (1.86934, 1.03835)
# Line #10 passes Point #7, Point #9. Norm direction: 312.59589. Distance to origin: 0.50084
# Circle #11 is centered at Point #5 and passes Point #1. Center: (1.47734, 0.99648). Radius: 1.04201
# Point #12 is intersection of Circle #6, Circle #11. Coordinates: (0.76669, 0.23440)
# Line #13 passes Point #3, Point #12. Norm direction: 287.00000. Distance to origin: 0.00000
# Point #14 is intersection of Line #13, LineSegment #8. Coordinates: (1.82904, 0.55919)
# Circle #15 is centered at Point #14 and passes Point #9. Center: (1.82904, 0.55919). Radius: 0.48085
# Point #16 is intersection of Line #10, Circle #15. Coordinates: (1.34819, 0.55919)
# Point #16 is a target

