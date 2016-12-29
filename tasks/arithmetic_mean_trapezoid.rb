# 5.5 5E attempt
# arithmetic mean in trapezoid

require './geometric-constructions'

top_width = 1.115
bottom_width = 2.703
height = 1.832
left_shift = 0.84

mean_width = Math.sqrt(top_width * bottom_width)

ld_point = Point.new([0, 0]).with_name('left down')
rd_point = Point.new([bottom_width, 0]).with_name('right down')
lu_point = Point.new([left_shift, height]).with_name('left up')
ru_point = Point.new([left_shift + top_width, height]).with_name('right up')

top_line = Line.new([lu_point, ru_point]).with_name('top line')
bottom_line = Line.new([ld_point, rd_point]).with_name('bottom line')

left_line = LineSegment.new([lu_point, ld_point])
right_line = LineSegment.new([ru_point, rd_point])

initial_layout = Layout.new(
  [ld_point, rd_point, lu_point, ru_point],
  [top_line, bottom_line, left_line, right_line], 
  [])

filters = {}

step_count = 4
moves = [:circle, :line]
generator_max = moves.length ** step_count

(3..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end

  p [generator, steps]

  layout = initial_layout.dup

  target_line = Line.new([Point.new([1, height/2]), Point.new([0, height/2])])
  targets = [target_line]
  
  task = Task.new(layout, targets, steps, filters)

  task.each_layout(print_interval: 100) do |layout|
    point1 = nil
    layout.points.each do |point|
      if (point.y - height/2).abs < EPSILON
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

# If top and bottom lines are extended, there's a solution
# [3, [:circle, :circle, :line, :line]]
# Layout has 14 points; 6 lines; 2 circles
# Line #0 is the top line. Norm direction: 90.00000. Distance to origin: 1.83200
# Line #1 is the bottom line. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #2 is the left down. Coordinates: (0.00000, 0.00000)
# Point #3 is the right up. Coordinates: (1.99000, 1.83200)
# Circle #4 is centered at Point #2 and passes Point #3. Center: (0.00000, 0.00000). Radius: 2.70487
# Point #5 is intersection of Line #1, Circle #4. Coordinates: (2.70487, -0.00000)
# Point #6 is intersection of Line #1, Circle #4. Coordinates: (-2.70487, 0.00000)
# Circle #7 is centered at Point #5 and passes Point #6. Center: (2.70487, -0.00000). Radius: 5.40974
# Point #8 is intersection of Line #0, Circle #7. Coordinates: (7.79497, 1.83200)
# Line #9 passes Point #8, Point #6. Norm direction: 99.89727. Distance to origin: 0.46492
# Point #10 is intersection of Line #9, Circle #4. Coordinates: (2.54505, 0.91600)
# Point #10 is a target
# Point #11 is intersection of Line #0, Circle #7. Coordinates: (-2.38523, 1.83200)
# Line #12 passes Point #6, Point #11. Norm direction: 170.10273. Distance to origin: 2.66462
# Point #13 is intersection of Line #12, Circle #4. Coordinates: (-2.54505, 0.91600)
# Point #13 is a target