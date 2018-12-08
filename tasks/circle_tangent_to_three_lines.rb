# 7.8 Circle Tangent to Three Lines 6E

require './geometric-constructions'

origin = Point.new([0, 0])
theta = Math::PI / 180 * 53.24
x = 1.0/Math.cos(theta)
y = 1.0/Math.sin(theta)

point_up = Point.new([0, y]).with_name('up')
point_down = Point.new([0, -y]).with_name('down')
point_left = Point.new([-x, 0]).with_name('left')
point_right = Point.new([x, 0]).with_name('right')
point_tangent = Point.new([Math.cos(theta), -Math.sin(theta)])

line_up_left = Line.new([point_up, point_left]).with_name('up left')
line_down_left = Line.new([point_down, point_left]).with_name('down left')
line_down_right = Line.new([point_down, point_right]).with_name('down right')

circle_target = Circle.new(origin, point_tangent)

initial_layout = Layout.new([point_left, point_down], [line_up_left, line_down_right, line_down_left], [])

# step1 = Circle.new(point_left, point_down)
# initial_layout << step1

targets = [origin, point_tangent]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

steps = [:circle, :circle, :circle, :line, :line,  ]
step_count = steps.length

filters = {}
# filters = {3 => [origin]}

task = Task.new(initial_layout, targets, steps, filters)
epsilon = 0.0000001

task.each_layout do |layout|
  layout.points.each do |each_point|
    distance = origin.distance_from(each_point)
    if distance < 1 + epsilon && distance > 1 - epsilon
      puts "Found a solution"
      layout.print([each_point])
      exit
    end
  end
end
puts "No solution found"


Found a solution
# Layout has 23 points; 4 lines; 3 circles
# Line #0 is the down right. Norm direction: 306.76000. Distance to origin: 1.00000
# Point #1 is the down. Coordinates: (0.00000, -1.24821)
# Point #2 is the left. Coordinates: (-1.67094, 0.00000)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (0.00000, -1.24821). Radius: 2.08568
# Point #4 is intersection of Line #0, Circle #3. Coordinates: (-1.67094, -2.49641)
# Point #5 is intersection of Line #0, Circle #3. Coordinates: (1.67094, 0.00000)
# Circle #6 is centered at Point #4 and passes Point #5. Center: (-1.67094, -2.49641). Radius: 4.17136
# Circle #7 is centered at Point #5 and passes Point #2. Center: (1.67094, 0.00000). Radius: 3.34189
# Point #8 is intersection of Circle #6, Circle #7. Coordinates: (2.43099, -3.25431)
# Point #9 is intersection of Circle #6, Circle #7. Coordinates: (-1.23406, 1.65201)
# Line #10 passes Point #8, Point #9. Norm direction: 36.76000. Distance to origin: 0.00000
# Line #11 is the up left. Norm direction: 126.76000. Distance to origin: 1.00000
# Point #12 is intersection of Line #10, Line #11. Coordinates: (-0.59846, 0.80115)
# Point #12 is a target
