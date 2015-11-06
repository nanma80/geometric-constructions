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
point_line = Line.new([origin, point])

xi = point_distance * Math.cos(point_theta)
zeta = point_distance
delta = Math.sqrt(xi ** 2.0 - (zeta * Math.cos(theta)) ** 2.0)
center_x = (xi - delta)/(Math.cos(theta) ** 2.0)
center = Point.new([center_x, 0])


initial_layout = Layout.new([origin, point], [upper_ray, lower_ray, bisector, point_line], [])
targets = [center]

steps = [:perp, :circle, :line, :parallel]

task = Task.new(initial_layout, targets, steps)

solution_layout = task.solve

solution_layout.print(targets)

# Found a solution
# Layout has 19 points; 7 lines; 1 circles
# Line #0 is predefined. Norm direction: 296.0. Distance to origin: 0.0
# Point #1 is predefined. Coordinates: (0.9702957262759965, 0.24192189559966773)
# Line #2 is perpendicular to Line #0 and passes Point #1. Norm direction: 25.999999999999993. Distance to origin: 0.9781476007338057
# Line #3 is predefined. Norm direction: 90.0. Distance to origin: 0.0
# Point #4 is intersection of Line #2, Line #3. Coordinates: (1.0882889186475826, -6.663847703846481e-17)
# Line #5 is predefined. Norm direction: 284.0. Distance to origin: 0.0
# Point #6 is intersection of Line #2, Line #0. Coordinates: (0.8791532399413593, 0.428791685462663)
# Circle #7 is centered at Point #4 and passes Point #6. Center: (1.0882889186475826, -6.663847703846481e-17). Radius: 0.4770744613053858
# Point #8 is intersection of Line #5, Circle #7. Coordinates: (1.4106259196265316, 0.35170854329930773)
# Line #9 passes Point #4, Point #8. Norm direction: 317.49508584033094. Distance to origin: 0.8023076926377469
# Line #10 is parallel to Line #9 and passes Point #1. Norm direction: 317.49508584033094. Distance to origin: 0.5518654623409056
# Point #11 is intersection of Line #10, Line #3. Coordinates: (0.748576977088897, -4.583711994536597e-17)
# Point #11 is a target
