# 12.4 Triangle by tangent points 10E
# Q1: can we create circle center in 5E? No
# Q2: given the naive steps to get circle center in 6E, 
# can we use 2E to get side_1, or side_2, or side_3? 
# No for side_1, side_2, or side_3
# Q3: can we save one line from the first 6E and get a point on a side?
# Yes. We can save lots of circles and lines

require './geometric-constructions'


point_1 = Point.new([0, 0]).with_name('point 1')
point_2 = Point.new([1, 0]).with_name('point 2')
point_3 = Point.new([0.623, - 0.8676]).with_name('point 3')

line_bisect_12 = Line.perp_bis([point_1, point_2])
line_bisect_13 = Line.perp_bis([point_1, point_3])
circle_center = line_bisect_12.intersection_with_line(line_bisect_13).first
# using the naive steps, it takes 6E to get circle_center


radius_1 = Line.new([circle_center, point_1])
side_1 = Line.perp(radius_1, point_1)
# using naive steps, it takes 6E + 3E to get side_1
vertex_12 = side_1.intersection_with_line(line_bisect_12).first
vertex_13 = side_1.intersection_with_line(line_bisect_13).first

side_2 = Line.new([vertex_12, point_2])
side_3 = Line.new([vertex_13, point_3])

vertex_23 = side_2.intersection_with_line(side_3).first

# p circle_center.coordinates
# p vertex_12.coordinates
# p vertex_13.coordinates
# p vertex_23.coordinates


initial_layout = Layout.new([point_1, point_2, point_3], [], [])

# naive steps to get circle center
# circle_12 = Circle.new(point_1, point_2).with_name('circle_12')
circle_21 = Circle.new(point_2, point_1).with_name('circle_21')
# intersections12 = circle_12.intersection_with_circle(circle_21)
# line_12 = Line.new(intersections12).with_name('line_12')

# intersections12.each do |int_point|
#   puts "intersections 12: #{int_point.coordinates}"
# end

# p line_12.normal_form
# p line_bisect_12.normal_form

# circle_13 = Circle.new(point_1, point_3).with_name('circle_13')
circle_31 = Circle.new(point_3, point_1).with_name('circle_31')
# intersections13 = circle_13.intersection_with_circle(circle_31)
# line_13 = Line.new(intersections13).with_name('line_13')

# intersections13.each do |int_point|
#   puts "intersections 13: #{int_point.coordinates}"
# end

# puts "circle center: #{circle_center.coordinates}"

# p line_13.normal_form
# p line_bisect_13.normal_form

initial_layout << circle_21
initial_layout << circle_31


targets = [side_3]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

step_count = 2
moves = [:line, :circle]
generator_max = moves.length ** step_count

filters = {}

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end

  # next unless steps[1] == :line

  p [generator, steps]

  layout = initial_layout.dup
  
  task = Task.new(layout, targets, steps, filters)

  task.each_layout(print_interval: 10, subsample_rate: 1.0) do |layout|
    layout.points.each do |each_point|
      if each_point == point_1 || each_point == point_2 || each_point == point_3
        next
      end

      # if each_point.on_line?(side_1)
      #   puts "\# Found a solution on side_1"
      #   layout.print([each_point])
      #   exit
      # end

      if each_point.on_line?(side_2)
        puts "\# Found a solution on side_2"
        layout.print([each_point])
        exit
      end

      # if each_point.on_line?(side_3)
      #   puts "\# Found a solution on side_3"
      #   layout.print([each_point])
      #   exit
      # end
    end
  end
end

puts "No solution found"

# Found a solution on side_1
# Layout has 10 points; 1 lines; 3 circles
# Point #0 is the point 1. Coordinates: (0.00000, 0.00000)
# Point #1 is predefined. Coordinates: (1.68234, -0.73103)
# Point #2 is the point 2. Coordinates: (1.00000, 0.00000)
# Line #3 passes Point #1, Point #2. Norm direction: 43.02702. Distance to origin: 0.73103
# Circle #4 is the circle_31. Center: (0.62300, -0.86760). Radius: 1.06811
# Point #5 is intersection of Line #3, Circle #4. Coordinates: (0.83214, 0.17983)
# Circle #6 is centered at Point #0 and passes Point #5. Center: (0.00000, 0.00000). Radius: 0.85135
# Point #7 is intersection of Circle #6, Circle #4. Coordinates: (-0.43634, -0.73103)
# Point #7 is a target

# Found a solution on side_2
# Layout has 9 points; 2 lines; 2 circles
# Point #0 is predefined. Coordinates: (1.68234, -0.73103)
# Point #1 is the point 3. Coordinates: (0.62300, -0.86760)
# Point #2 is the point 2. Coordinates: (1.00000, 0.00000)
# Line #3 passes Point #1, Point #2. Norm direction: 336.51351. Distance to origin: 0.91715
# Circle #4 is the circle_31. Center: (0.62300, -0.86760). Radius: 1.06811
# Point #5 is intersection of Line #3, Circle #4. Coordinates: (0.19732, -1.84722)
# Line #6 passes Point #0, Point #5. Norm direction: 306.92971. Distance to origin: 1.59518
# Circle #7 is the circle_21. Center: (1.00000, 0.00000). Radius: 1.00000
# Point #8 is intersection of Line #6, Circle #7. Coordinates: (1.51253, -0.85867)
# Point #8 is a target
