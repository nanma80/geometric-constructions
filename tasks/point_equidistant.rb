# 12.4 Point equidistant from side of angle and point, 5L, compass x2
# Try to solve it without an extra point on bisector first
# Point line is useless

require './geometric-constructions'

origin = Point.new([0, 0])
theta = 26 * Math::PI / 180
point_theta = 14 * Math::PI / 180

upper_ray_distance = 223.1
point_distance = 1.0

upper_ray = LineSegment.new([origin, Point.new([upper_ray_distance * Math.cos(theta), upper_ray_distance * Math.sin(theta)])]).with_name('upper ray')
bisector = LineSegment.new([origin, Point.new([10000.1, 0])]).with_name('horizontal ray')
point = Point.new([point_distance * Math.cos(point_theta), point_distance * Math.sin(point_theta)]).with_name('given point')

xi = point_distance * Math.cos(point_theta)
zeta = point_distance
delta = Math.sqrt(xi ** 2.0 - (zeta * Math.cos(theta)) ** 2.0)
center_x = (xi - delta)/(Math.cos(theta) ** 2.0)
center = Point.new([center_x, 0])

target_line = Line.perp(upper_ray, center)

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]

step_count = 3
generator_max = l_moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  p [generator, steps]
  next unless steps.count(:compass) >= 2

  initial_layout = Layout.new([origin, point], [upper_ray, bisector], [])
  targets = [target_line]

  task = Task.new(initial_layout, targets, steps)

  task.each_layout do |layout|
    layout.points.each do |each_point|
      line = Line.perp(upper_ray, each_point)
      if line == target_line
        puts "Found a solution"
        layout.print([each_point])
        exit
      end
    end
  end
  puts "No solution found"
end

# Layout has 16 points; 3 lines; 2 circles
# LineSegment #0 is the upper ray. Norm direction: 296.00000. Distance to origin: 0.00000
# LineSegment #1 is the horizontal ray. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #2 is the given point. Coordinates: (0.97030, 0.24192)
# Line #3 is perpendicular to LineSegment #1 and passes Point #2. Norm direction: 0.00000. Distance to origin: 0.97030
# Point #4 is intersection of Line #3, LineSegment #0. Coordinates: (0.97030, 0.47324)
# Point #5 is intersection of Line #3, LineSegment #1. Coordinates: (0.97030, -0.00000)
# Circle #6 is centered at Point #2 and radius is the distance between Point #5, Point #4. Center: (0.97030, 0.24192). Radius: 0.47324
# Point #7 is intersection of LineSegment #1, Circle #6. Coordinates: (1.37703, -0.00000)
# Circle #8 is centered at Point #4 and radius is the distance between Point #5, Point #7. Center: (0.97030, 0.47324). Radius: 0.40674
# Point #9 is intersection of LineSegment #0, Circle #8. Coordinates: (0.60472, 0.29494)
# Point #9 is a target
