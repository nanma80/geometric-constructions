# 13.8 9E line_circle_intersection_star.rb

require './geometric-constructions'

distance = 2.23

center_point = Point.new([0, 0]).with_name('circle center')
left_point = Point.new([-1, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right point')
distant_point = Point.new([-distance, 0]).with_name('distant point')
circle = Circle.new(center_point, left_point).with_name('original circle')

initial_layout = Layout.new([center_point, distant_point], [], [circle])

steps = [:circle] * 8

step1 = Circle.new(distant_point, center_point)
intersections1 = step1.intersection_with_circle(circle).sort_by{|point| - point.y}
up_point = intersections1[0]
down_point = intersections1[1]

step2 = Circle.new(up_point, center_point)
step3 = Circle.new(down_point, center_point)

up_point2 = step2.intersection_with_circle(step1).sort_by{|point| point.y}[1]
down_point2 = step3.intersection_with_circle(step1).sort_by{|point| point.y}[0]

step4 = Circle.new(center_point, up_point2)

up_ortho = step2.intersection_with_circle(step4).sort_by { |point|  point.x}[1]
down_ortho = step3.intersection_with_circle(step4).sort_by { |point|  point.x}[1]

step5 = Circle.new(up_ortho, down_point)
step6 = Circle.new(down_ortho, up_point)

right1 = step5.intersection_with_circle(step6).first
left1 = step5.intersection_with_circle(step6).last
step7 = Circle.new(center_point, left1)

step8 = Circle.new(up_ortho, center_point)

filters = {
  1 => [step1],
  2 => [step2],
  3 => [step3],
  4 => [step4],
  5 => [step5],
  6 => [step6],
  # 7 => [step7],
  # 8 => [step8],
}

targets = [left_point, right_point]

task = Task.new(initial_layout, targets, steps, filters)

target_distance = up_ortho.distance_from(left_point)
task.each_layout(print_interval: 1) do |layout|
  layout.points.each do |point|
    if (target_distance - up_ortho.distance_from(point)).abs < EPSILON
      puts "Found a solution"
      layout.print([point])
      exit
    end
  end
end
puts "No solution found"


# Layout has 44 points; 0 lines; 9 circles
# Point #0 is the distant point. Coordinates: (-2.23000, 0.00000)
# Point #1 is the circle center. Coordinates: (0.00000, 0.00000)
# Circle #2 is centered at Point #0 and passes Point #1. Center: (-2.23000, 0.00000). Radius: 2.23000
# Circle #3 is the original circle. Center: (0.00000, 0.00000). Radius: 1.00000
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (-0.22422, 0.97454)
# Point #5 is intersection of Circle #2, Circle #3. Coordinates: (-0.22422, -0.97454)
# Circle #6 is centered at Point #5 and passes Point #1. Center: (-0.22422, -0.97454). Radius: 1.00000
# Point #7 is intersection of Circle #6, Circle #2. Coordinates: (-0.85177, -1.75311)
# Circle #8 is centered at Point #1 and passes Point #7. Center: (0.00000, 0.00000). Radius: 1.94908
# Point #9 is intersection of Circle #8, Circle #6. Coordinates: (0.00000, -1.94908)
# Circle #10 is centered at Point #9 and passes Point #4. Center: (0.00000, -1.94908). Radius: 2.93220
# Circle #11 is centered at Point #4 and passes Point #1. Center: (-0.22422, 0.97454). Radius: 1.00000
# Point #12 is intersection of Circle #8, Circle #11. Coordinates: (0.00000, 1.94908)
# Circle #13 is centered at Point #12 and passes Point #5. Center: (0.00000, 1.94908). Radius: 2.93220
# Point #14 is intersection of Circle #10, Circle #13. Coordinates: (-2.19064, 0.00000)
# Circle #15 is centered at Point #4 and passes Point #14. Center: (-0.22422, 0.97454). Radius: 2.19467
# Point #16 is intersection of Circle #10, Circle #3. Coordinates: (0.22422, 0.97454)
# Circle #17 is centered at Point #16 and passes Point #14. Center: (0.22422, 0.97454). Radius: 2.60409
# Point #18 is intersection of Circle #15, Circle #17. Coordinates: (-2.19064, 1.94908)
# Point #18 is a target
