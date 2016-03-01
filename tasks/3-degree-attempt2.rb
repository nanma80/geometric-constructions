# Trying 10.9 3-degree for 7E
# What we have learned:
# 7E not possible if we follow old path (54 deg) until finishing golden circle
# 7E unlikely (20% checked) if we follow old path (54 deg) until finishing connecting line

require './geometric-constructions'

center_point = Point.new([0, 0]).with_name("vertex of ray")
right_point = Point.new([1, 0]).with_name("arbitrary point on ray")
very_right_point = Point.new([10000000.0, 0])
horizontal_line = LineSegment.new([center_point, very_right_point]).with_name("ray")

up_distance = 2.23
theta = 3 * Math::PI / 180
up_point = Point.new([up_distance * Math.cos(theta), up_distance * Math.sin(theta)])
line2 = Line.new([center_point, up_point])

right_circle = Circle.new(right_point, center_point).with_name('right circle')
left_circle = Circle.new(center_point, right_point).with_name('left circle')
big_right_circle = Circle.new(Point.new([2, 0]), center_point).with_name('big right circle')
right_circle_2 = Circle.new(Point.new([2, 0]), right_point).with_name('further right circle')

up_intersection = left_circle.intersection_with_circle(right_circle).select{|p| p.y > 0}.first
down_intersection = left_circle.intersection_with_circle(big_right_circle).select{|p| p.y < 0}.first
connecting_line = Line.new([up_intersection, down_intersection]).with_name('line connecting intersections')
golden_point = connecting_line.intersection_with_line(horizontal_line).first
golden_circle = Circle.new(Point.new([2, 0]), golden_point).with_name('golden circle')

initial_layout = Layout.new([center_point, right_point], [horizontal_line], [])
# initial_layout << right_circle
# initial_layout << left_circle
# initial_layout << big_right_circle
# initial_layout << connecting_line
# initial_layout << golden_circle
# initial_layout << right_circle_2

targets = [line2]

# 0001101
steps = [:circle, :circle, :circle, :line, :line, :circle]

filters = {}

task = Task.new(initial_layout, targets, steps, filters)

task.each_layout do |layout|
  layout.points.each do |point|
    if point.x > EPSILON && (point.y.abs/point.x - Math.tan(theta)).abs < EPSILON
      puts "Found a solution"
      layout.print([point])
      exit
    end
  end
end
puts "No solution found"

# Layout has 19 points; 3 lines; 4 circles
# LineSegment #0 is the ray. Norm direction: 90.0. Distance to origin: 0.0
# Point #1 is the arbitrary point on ray. Coordinates: (1.0, 0.0)
# Point #2 is the vertex of ray. Coordinates: (0.0, 0.0)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (1.0, 0.0). Radius: 1.0
# Point #4 is intersection of LineSegment #0, Circle #3. Coordinates: (2.0, -1.2246467991473532e-16)
# Circle #5 is centered at Point #4 and passes Point #1. Center: (2.0, -1.2246467991473532e-16). Radius: 1.0
# Point #6 is intersection of LineSegment #0, Circle #5. Coordinates: (3.0, -1.8369701987210297e-16)
# Point #7 is intersection of Circle #5, Circle #3. Coordinates: (1.5, 0.8660254037844386)
# Circle #8 is centered at Point #6 and passes Point #7. Center: (3.0, -1.8369701987210297e-16). Radius: 1.7320508075688774
# Point #9 is intersection of LineSegment #0, Circle #8. Coordinates: (4.732050807568878, -2.8975454374459364e-16)
# Point #10 is intersection of Circle #5, Circle #3. Coordinates: (1.5, -0.8660254037844386)
# Line #11 passes Point #9, Point #10. Norm direction: 285.0. Distance to origin: 1.2247448713915887
# Point #12 is intersection of Line #11, Circle #3. Coordinates: (1.0, -1.0)
# Line #13 passes Point #4, Point #12. Norm direction: 315.0. Distance to origin: 1.4142135623730951
# Point #14 is intersection of Line #13, Circle #8. Coordinates: (3.618033988749896, 1.6180339887498947)
# Circle #15 is centered at Point #2 and passes Point #14. Center: (0.0, 0.0). Radius: 3.9633576589174204
# Point #16 is intersection of Line #11, Circle #15. Coordinates: (3.9579260149906808, -0.2074261130122398)
# Point #16 is a target
