# 14.8 7E line_circle_intersection_star

require './geometric-constructions'

distance = 2.23

center_point = Point.new([0, 0]).with_name('circle center')
left_point = Point.new([-1, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')
distant_point = Point.new([-distance, 0]).with_name('distant point')
circle = Circle.new(center_point, left_point).with_name('original circle')

initial_layout = Layout.new([center_point, distant_point], [], [circle])

steps = [:circle] * 3

step1 = Circle.new(distant_point, center_point)
intersections1 = step1.intersection_with_circle(circle).sort_by{|point| - point.y}
up_point = intersections1[0]
down_point = intersections1[1]
puts "up_point: #{up_point.coordinates}"
puts "down_point: #{down_point.coordinates}"
initial_layout << step1

step2 = Circle.new(up_point, center_point)
initial_layout << step2

up_point2 = step2.intersection_with_circle(step1).sort_by{|point| point.y}[1]
puts "up_point2: #{up_point2.coordinates}"

step3 = Circle.new(center_point, up_point2)
initial_layout << step3

up_ortho = step2.intersection_with_circle(step3).sort_by { |point|  point.x}[1]
raise "up_ortho not in layout" unless initial_layout.contains?([up_ortho])

puts "up_ortho: #{up_ortho.coordinates}"

filters = {
}

targets = [left_point, right_point]

task = Task.new(initial_layout, targets, steps, filters)

target_distance = up_ortho.distance_from(left_point)
task.each_layout(print_interval: 10) do |layout|
  layout.points.each do |point|
    if (target_distance - up_ortho.distance_from(point)).abs < EPSILON
      puts "Found a solution"
      layout.print([point])
      exit
    end
  end
end
puts "No solution found"

# up_point: [-0.22421524663677106, 0.9745396467951483]
# down_point: [-0.22421524663677106, -0.9745396467951483]
# up_point2: [-0.8517735633861991, 1.7531092063584701]
# up_ortho: [8.881784197001252e-16, 1.9490792935902963]

# Layout has 26 points; 0 lines; 7 circles
# Point #0 is predefined. Coordinates: (-0.85177, -1.75311)
# Point #1 is predefined. Coordinates: (-0.22422, 0.97454)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (-0.85177, -1.75311). Radius: 2.79891
# Circle #3 is predefined. Center: (-0.22422, 0.97454). Radius: 1.00000
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (0.69459, 0.57984)
# Point #5 is predefined. Coordinates: (-0.95608, 0.29309)
# Point #6 is predefined. Coordinates: (-0.85177, 1.75311)
# Circle #7 is centered at Point #5 and passes Point #6. Center: (-0.95608, 0.29309). Radius: 1.46374
# Circle #8 is predefined. Center: (0.00000, 0.00000). Radius: 1.94908
# Point #9 is intersection of Circle #7, Circle #8. Coordinates: (-1.68795, -0.97454)
# Circle #10 is centered at Point #4 and passes Point #9. Center: (0.69459, 0.57984). Radius: 2.84475
# Point #11 is intersection of Circle #10, Circle #7. Coordinates: (-2.07258, 1.23964)
# Point #11 is a target
