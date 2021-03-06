# 8.8 5E attempt
# try to use 4E to get two points with the target height

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
initial_layout << cross_line2

bottom_mid_point = Point.new([bottom_width / 2.0, 0])
target_height = Line.new([bottom_mid_point, lu_point]).intersection_with_line(cross_line2).first.y
target_line = Line.new([Point.new([1, target_height]), Point.new([0, target_height])])
targets = [target_line]

filters = {}

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

  task.each_layout(print_interval: 100, subsample_rate:0.3) do |layout|
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
# Point #0 is the left down. Coordinates: (0.00000, 0.00000)
# Point #1 is the left up. Coordinates: (0.84000, 1.83200)
# Point #2 is the right up. Coordinates: (1.95500, 1.83200)
# Line #3 passes Point #1, Point #2. Norm direction: 90.00000. Distance to origin: 1.83200
# Circle #4 is centered at Point #2 and passes Point #1. Center: (1.95500, 1.83200). Radius: 1.11500
# Point #5 is intersection of Line #3, Circle #4. Coordinates: (3.07000, 1.83200)
# Line #6 passes Point #0, Point #5. Norm direction: 300.82633. Distance to origin: 0.00000
# LineSegment #7 is the lu rd cross line. Norm direction: 45.48068. Distance to origin: 1.89521
# Point #8 is intersection of Line #6, LineSegment #7. Coordinates: (1.68218, 1.00383)
# Point #8 is a target
# Point #9 is predefined. Coordinates: (1.38407, 1.29699)
# Line #10 passes Point #9, Point #5. Norm direction: 107.60628. Distance to origin: 0.81759
# LineSegment #11 is the left line. Norm direction: 335.36782. Distance to origin: 0.00000
# Point #12 is intersection of Line #10, LineSegment #11. Coordinates: (0.46027, 1.00383)
# Point #12 is a target
