require './geometric-constructions'

short = 1.0
long = 2.23
geo_mean = Math.sqrt(short * long)
center_point = Point.new([0, 0])
left_point = Point.new([- short, 0])
right_point = Point.new([long, 0])
horizontal_line = Line.new([center_point, left_point])

theta = 86 * Math::PI / 180
up_point = Point.new([geo_mean * Math.cos(theta), geo_mean * Math.sin(theta)])
line2 = Line.new([center_point, up_point])


initial_layout = Layout.new([center_point, left_point, right_point], [horizontal_line, line2], [])
targets = [up_point]

steps = [:circle, :circle, :circle, :line, :circle]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)
