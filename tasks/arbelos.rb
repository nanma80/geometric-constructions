# 14.5 Arbelos

require './geometric-constructions'

origin = Point.new([0, 0]).with_name('origin')
r1 = 1.0
r2 = 1.879
center1 = Point.new([-r1, 0]).with_name('center1')
center2 = Point.new([r2, 0]).with_name('center2')
circle1 = Circle.new(center1, origin).with_name('circle1')
circle2 = Circle.new(center2, origin).with_name('circle2')
point_left = Point.new([-r1*2, 0]).with_name('point_left')
point_right = Point.new([r2*2, 0]).with_name('point_right')

center3 = Point.new([-r1 + r2, 0]).with_name('center3')
circle3 = Circle.new(center3, point_left).with_name('circle3')
r3 = r1 + r2

initial_layout = Layout.new([center1, center2, center3, origin, point_left], [], [circle1, circle2, circle3])

targets = [Point.new([43.0, 31.79])]

steps = [:perp_bis, :circle, :line, :line]

task = Task.new(initial_layout, targets, steps)
epsilon = 0.00001

task.each_layout do |layout|
  layout.points.each do |each_point|
    dist1 = center1.distance_from(each_point)
    dist2 = center2.distance_from(each_point)
    dist3 = center3.distance_from(each_point)
    if ((dist1 - r1) - (dist2 - r2)).abs < epsilon && ((dist1 - r1) - (r3 - dist3)).abs < epsilon
      puts "Found a solution"
      layout.print([each_point])
      exit
    end
  end
end
puts "No solution found"

# Layout has 24 points; 3 lines; 4 circles
# Point #0 is the center2. Coordinates: (1.87900, 0.00000)
# Point #1 is the origin. Coordinates: (0.00000, 0.00000)
# Point #2 is the point_left. Coordinates: (-2.00000, 0.00000)
# Line #3 is perpendicular bisector of Point #1, Point #2. Norm direction: 180.00000. Distance to origin: 1.00000
# Circle #4 is the circle1. Center: (-1.00000, 0.00000). Radius: 1.00000
# Point #5 is intersection of Line #3, Circle #4. Coordinates: (-1.00000, -1.00000)
# Circle #6 is centered at Point #5 and passes Point #1. Center: (-1.00000, -1.00000). Radius: 1.41421
# Circle #7 is the circle2. Center: (1.87900, 0.00000). Radius: 1.87900
# Point #8 is intersection of Circle #6, Circle #7. Coordinates: (0.40458, -1.16479)
# Line #9 passes Point #0, Point #8. Norm direction: 308.30861. Distance to origin: 1.16479
# Circle #10 is the circle3. Center: (0.87900, 0.00000). Radius: 2.87900
# Point #11 is intersection of Circle #6, Circle #10. Coordinates: (-0.72910, -2.38802)
# Point #12 is the center3. Coordinates: (0.87900, 0.00000)
# Line #13 passes Point #11, Point #12. Norm direction: 326.04364. Distance to origin: 0.72910
# Point #14 is intersection of Line #9, Line #13. Coordinates: (-0.25768, -1.68797)
# Point #14 is a target