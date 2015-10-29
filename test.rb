require './geometric-constructions'

l1 = Line.new([Point.new([1, 0]), Point.new([0, 1])])
l2 = Line.new([Point.new([0, 0]), Point.new([1, 1])])
l3 = Line.new([Point.new([-1, 0]), Point.new([3, 0])])

p l1.intersection_with_line(l3)