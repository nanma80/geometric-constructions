require './geometric-constructions'

p1 = Point.new([2, 0])
p2 = Point.new([-2, 0])

l1 = Line.new([p1, p2])
p l1

p3 = Point.new([0, 2])
p4 = Point.new([0, -1])

l2 = Line.new([p3, p4])

p l2