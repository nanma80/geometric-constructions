# 8.8 5E
# Assume that first three moves creates p_cross2

require './geometric-constructions'

top_width = 1.115
bottom_width = 2.703
height = 1.832
left_shift = 0.84

ld_point = Point.new([0, 0]).with_name('left down')
rd_point = Point.new([bottom_width, 0]).with_name('right down')
lu_point = Point.new([left_shift, height]).with_name('left up')
ru_point = Point.new([left_shift + top_width, height]).with_name('right up')

top_line = LineSegment.new([lu_point, ru_point]).with_name('top line')
bottom_line = LineSegment.new([ld_point, rd_point]).with_name('bottom line')

left_line = LineSegment.new([lu_point, ld_point]).with_name('left line')
right_line = LineSegment.new([ru_point, rd_point]).with_name('right line')

cross_line1 = LineSegment.new([lu_point, rd_point]).with_name('lu rd cross line')
cross_line2 = LineSegment.new([ru_point, ld_point]).with_name('ru ld cross line')

initial_layout = Layout.new(
  [ld_point, rd_point, lu_point, ru_point],
  [top_line, bottom_line, left_line, right_line, cross_line1], 
  [])

initial_layout << cross_line2 # generate central crossing point automatically

bottom_mid_point = Point.new([bottom_width / 2.0, 0])
target_height = Line.new([bottom_mid_point, lu_point]).intersection_with_line(cross_line2).first.y
target_line = Line.new([Point.new([1, target_height]), Point.new([0, target_height])])
targets = [target_line]

p_left = left_line.intersection_with_line(target_line).first
p_cross1 = cross_line1.intersection_with_line(target_line).first
p_cross2 = cross_line2.intersection_with_line(target_line).first
p_right = right_line.intersection_with_line(target_line).first

puts p_cross2.x - p_left.x
puts p_cross1.x - p_cross2.x
puts p_right.x - p_cross1.x

# exit

filters = {
  3 => [ p_cross2 ]
}

step_count = 4
moves = [:line, :circle]
generator_max = moves.length ** step_count

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end

  p [generator, steps]

  layout = initial_layout.dup
  
  task = Task.new(layout, targets, steps, filters)

  task.each_layout(print_interval: 100, subsample_rate:1.0) do |layout|
    point1 = nil
    layout.points.each do |point|
      if (point.y - target_height).abs < EPSILON
        if point1.nil?
          point1 = point
        else
          puts "testing another point"
          if (point.x - point1.x).abs > EPSILON
            point2 = point
            
            puts "Found a solution"
            layout.print([point1, point2])
            exit
          end
        end
      end
    end
  end
end

puts "No solution found"

# Layout has 15 points; 9 lines; 1 circles
# Point #0 is the left up. Coordinates: (0.84000, 1.83200)
# Point #1 is the right up. Coordinates: (1.95500, 1.83200)
# Line #2 passes Point #0, Point #1. Norm direction: 90.00000. Distance to origin: 1.83200
# Circle #3 is centered at Point #0 and passes Point #1. Center: (0.84000, 1.83200). Radius: 1.11500
# Point #4 is intersection of Line #2, Circle #3. Coordinates: (-0.27500, 1.83200)
# Point #5 is the right down. Coordinates: (2.70300, 0.00000)
# Line #6 passes Point #4, Point #5. Norm direction: 58.40109. Distance to origin: 1.41629
# LineSegment #7 is the ru ld cross line. Norm direction: 313.13971. Distance to origin: 0.00000
# Point #8 is intersection of Line #6, LineSegment #7. Coordinates: (1.07123, 1.00383)
# Point #8 is a target
# Point #9 is predefined. Coordinates: (1.38407, 1.29699)
# Line #10 passes Point #9, Point #4. Norm direction: 72.12661. Distance to origin: 1.65918
# LineSegment #11 is the right line. Norm direction: 22.21004. Distance to origin: 2.50245
# Point #12 is intersection of Line #10, LineSegment #11. Coordinates: (2.29314, 1.00383)
# Point #12 is a target
