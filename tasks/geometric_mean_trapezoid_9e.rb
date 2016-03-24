# geometric mean in trapezoid 9E
# Sequence 110001101
# The first two lines are extensions of sides. The last line is the target

require './geometric-constructions'

top_width = 1.15
bottom_width = 2.703
height = 1.332
left_shift = 0.84

mean_width = Math.sqrt(top_width * bottom_width)

ld_point = Point.new([0, 0]).with_name('left down')
rd_point = Point.new([bottom_width, 0]).with_name('right down')
lu_point = Point.new([left_shift, height]).with_name('left up')
ru_point = Point.new([left_shift + top_width, height]).with_name('right up')

top_line = LineSegment.new([lu_point, ru_point]).with_name('top line')
bottom_line = LineSegment.new([ld_point, rd_point]).with_name('bottom line')

# Sides before extension. Not used
# left_line = LineSegment.new([lu_point, ld_point])
# right_line = LineSegment.new([ru_point, rd_point])

# extended lines. First two steps
left_line_extended = Line.new([lu_point, ld_point]).with_name('extended left line')
right_line_extended = Line.new([ru_point, rd_point]).with_name('extended right line')

top_point = left_line_extended.intersection_with_line(right_line_extended).first.with_name('top point')

initial_layout = Layout.new([ld_point, rd_point, lu_point, ru_point, top_point], [top_line, bottom_line, left_line_extended, right_line_extended], [])

raise unless initial_layout.contains?([top_point])

# subject to change
r1_point = ru_point
r2_point = rd_point

# potential swap
# r1_point, r2_point = r2_point, r1_point

# perp bis between top point and r1 point. Steps 3, 4, 5
circle1 = Circle.new(top_point, r1_point).with_name('circle with top point as center and passing right 1')
circle2 = Circle.new(r1_point, top_point).with_name('circle with right 1 point as center and passing top')
circle_intersections = circle1.intersection_with_circle(circle2)
perp_bis_line = Line.new(circle_intersections).with_name('perp bis line between top and right 1')

initial_layout << circle1
initial_layout << circle2
initial_layout << perp_bis_line

raise unless initial_layout.contains?(circle_intersections)

# circle from r2 to top. Step 6
circle3 = Circle.new(r2_point, top_point).with_name('circle with right 2 point as center and passing top')
circle_line_intersection = perp_bis_line.intersection_with_circle(circle3).first

initial_layout << circle3
raise unless initial_layout.contains?([circle_line_intersection])

# Step 7
circle4 = Circle.new(top_point, circle_line_intersection).with_name('circle centered at top and passing right end')
initial_layout << circle4

right_end = circle4.intersection_with_line(right_line_extended).sort_by { |point| point.y }[0]
height = right_end.y

puts "Target height: #{height}"

target_line = Line.new([right_end, Point.new([0, height])])

raise unless initial_layout.contains?([right_end])

targets = [target_line]

steps = [:line]

filters = {}

task = Task.new(initial_layout, targets, steps, filters)

task.each_layout(print_interval: 10) do |layout|
  point1 = nil
  layout.points.each do |point|
    if (point.y - height).abs < EPSILON
      if point1.nil?
        point1 = point
      else
        puts "testing another point"
        if (point.x - point1.x).abs > EPSILON
          point2 = point
          
          puts "Found a solution"
          layout.print([point1, point2])
          exit
        end
      end
    end
  end
end
puts "No solution found"

# Layout has 36 points; 6 lines; 4 circles
# Point #0 is predefined. Coordinates: (2.27147, 0.80616)
# Point #0 is a target
# Point #1 is the top point. Coordinates: (1.46202, 2.31835)
# Point #2 is predefined. Coordinates: (0.93404, 1.33200)
# Line #3 passes Point #1, Point #2. Norm direction: 331.84051. Distance to origin: 0.19488
# Circle #4 is the circle centered at top and passing right end. Center: (1.46202, 2.31835). Radius: 1.71520
# Point #5 is intersection of Line #3, Circle #4. Coordinates: (0.65257, 0.80616)
# Point #5 is a target
