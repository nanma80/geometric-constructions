require './geometric-constructions'

ax = 0.0
ay = -1
bx = 0.0
by = 1.3
cx = 2.5
cy = 0.0

p1 = Point.new([ax, ay])
p2 = Point.new([bx, by])
p3 = Point.new([cx, cy])

d = 2 * (ax * (by - cy) + bx * (cy - ay) + cx * (ay - by))
center_x = ((ax * ax + ay * ay) * (by - cy) + (bx * bx + by * by) * (cy - ay) + (cx * cx + cy * cy)* (ay - by))/d
center_y = ((ax * ax + ay * ay) * (cx - bx) + (bx * bx + by * by) * (ax - cx) + (cx * cx + cy * cy)* (bx - ax))/d
center = Point.new([center_x, center_y])

targets = [Circle.new(center, p3)]

initial_layout = Layout.new([p1, p2, p3], [], [])

task = Task.new(initial_layout, targets, [:perp_bis, :perp_bis, :circle])
solution_layout = task.solve

solution_layout.print(targets)
