# 8.5 triangle cleaver

require './geometric-constructions'

origin = Point.new([0, 0])
half_bottom_length = 1.0
bottom_left = Point.new([- half_bottom_length, 0]).with_name('bottom_left')
bottom_right = Point.new([half_bottom_length, 0]).with_name('bottom_right')
top = Point.new([-0.31, 1.13]).with_name('top')

left_side = LineSegment.new([top, bottom_left]).with_name('left_side')
right_side = LineSegment.new([top, bottom_right]).with_name('right_side')
bottom_side = LineSegment.new([bottom_left, bottom_right]).with_name('bottom_side')

top_bis = Line.angle_bis(top, [bottom_left, bottom_right])
target_line = Line.parallel(top_bis, origin)
step1 = Line.perp_bis([bottom_left, bottom_right]).with_name('step 1')

initial_layout = Layout.new([bottom_left, bottom_right, top], [left_side, right_side, bottom_side], [])
initial_layout << step1
puts initial_layout.contains?([origin])

targets = [target_line]

steps = [:circle, :circle, :circle, :line]

task = Task.new(initial_layout, targets, steps)

task.each_layout do |layout|
  layout.points.each do |point|
    if origin.distance_from(point).abs > 0.0001 && target_line.contains?(point)
      puts "Found a solution"
      layout.print([point])
      exit
    end
  end
end

# Layout has 17 points; 4 lines; 3 circles
# LineSegment #0 is the right_side. Norm direction: 49.21910. Distance to origin: 0.65317
# Point #1 is the top. Coordinates: (-0.31000, 1.13000)
# Point #2 is the bottom_left. Coordinates: (-1.00000, 0.00000)
# Circle #3 is centered at Point #1 and passes Point #2. Center: (-0.31000, 1.13000). Radius: 1.32401
# Point #4 is intersection of LineSegment #0, Circle #3. Coordinates: (0.69256, 0.26520)
# Point #5 is predefined. Coordinates: (-0.00000, 0.00000)
# Circle #6 is centered at Point #4 and passes Point #5. Center: (0.69256, 0.26520). Radius: 0.74160
# Circle #7 is centered at Point #2 and passes Point #5. Center: (-1.00000, 0.00000). Radius: 1.00000
# Point #8 is intersection of Circle #6, Circle #7. Coordinates: (-0.04792, 0.30586)
# Point #8 is a target
