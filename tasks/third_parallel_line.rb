# 10.5 third parallel line 7L 7E
require './geometric-constructions'

x_offset_middle = 1.011
x_offset_bottom = 1.135

bottom_left = Point.new([0, 0]).with_name('bottom left')
bottom_right = Point.new([x_offset_bottom, 0]).with_name('bottom right')

middle_left = Point.new([0, 1]).with_name('middle left')
middle_right = Point.new([x_offset_middle, 1]).with_name('middle right')

top_x = 0.35
top_y = 2.11

top = Point.new([top_x, top_y]).with_name('top')
bottom_line = Line.new([bottom_left, bottom_right]).with_name('bottom line')
middle_line = Line.new([middle_left, middle_right]).with_name('middle line')

top_line = Line.new([top, Point.new([0, top_y])])

# initial_layout = Layout.new([bottom_left, bottom_right, top], [bottom_line, middle_line], [])
initial_layout = Layout.new([bottom_left, bottom_right, middle_right, top], [bottom_line, middle_line], [])

targets = [top_line]

steps = [:line] * 6
filters = {}

task = Task.new(initial_layout, targets, steps, filters)

task.each_layout do |layout|
  layout.points.each do |point|
    if (point.y - top_y).abs < EPSILON && point.x != top_x
      puts '# Found a solution'
      layout.print([point])
      exit
    end
  end
end

# solution_layout = task.solve

# if solution_layout.nil?
# else
#   puts "\# *************Found solution*************"
#   puts '# ' + steps.inspect
#   solution_layout.print(targets)
#   exit
# end

# Found a solution
# Layout has 13 points; 8 lines; 0 circles
# Point #0 is the bottom right. Coordinates: (1.13500, 0.00000)
# Point #1 is the middle right. Coordinates: (1.01100, 1.00000)
# Point #2 is the bottom left. Coordinates: (0.00000, 0.00000)
# Point #3 is the top. Coordinates: (0.35000, 2.11000)
# Line #4 passes Point #2, Point #3. Norm direction: 350.58172. Distance to origin: 0.00000
# Line #5 is the middle line. Norm direction: 90.00000. Distance to origin: 1.00000
# Point #6 is intersection of Line #4, Line #5. Coordinates: (0.16588, 1.00000)
# Line #7 passes Point #6, Point #0. Norm direction: 44.10165. Distance to origin: 0.81505
# Line #8 passes Point #1, Point #2. Norm direction: 314.68660. Distance to origin: 0.00000
# Point #9 is intersection of Line #7, Line #8. Coordinates: (0.57950, 0.57320)
# Line #10 passes Point #9, Point #3. Norm direction: 8.49362. Distance to origin: 0.65781
# Line #11 is the bottom line. Norm direction: 90.00000. Distance to origin: 0.00000
# Point #12 is intersection of Line #10, Line #11. Coordinates: (0.66510, -0.00000)
# Line #13 passes Point #1, Point #12. Norm direction: 340.91957. Distance to origin: 0.62856
# Point #14 is intersection of Line #13, Line #4. Coordinates: (-0.61284, -3.69456)
# Line #15 passes Point #0, Point #14. Norm direction: 334.68186. Distance to origin: 1.02598
# Point #16 is intersection of Line #15, Line #8. Coordinates: (2.13321, 2.11000)
# Point #16 is a target

