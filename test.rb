# Circle in angle with E moves
require './geometric-constructions'

origin = Point.new([0, 0])
theta = 26 * Math::PI / 180
point_theta = 14 * Math::PI / 180

upper_ray_distance = 2.23
lower_ray_distance = 2.26
point_distance = 1.0

upper_ray = Line.new([origin, Point.new([upper_ray_distance * Math.cos(theta), upper_ray_distance * Math.sin(theta)])])
lower_ray = Line.new([origin, Point.new([lower_ray_distance * Math.cos(- theta), lower_ray_distance * Math.sin(- theta)])])
bisector = Line.new([origin, Point.new([10, 0])])
point = Point.new([point_distance * Math.cos(point_theta), point_distance * Math.sin(point_theta)])

xi = point_distance * Math.cos(point_theta)
zeta = point_distance
delta = Math.sqrt(xi ** 2.0 - (zeta * Math.cos(theta)) ** 2.0)
center_x = (xi - delta)/(Math.cos(theta) ** 2.0)
center = Point.new([center_x, 0])

initial_layout = Layout.new([origin, point], [upper_ray, lower_ray, bisector], [])
targets = [center]

steps = [:circle, :circle, :line, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)
