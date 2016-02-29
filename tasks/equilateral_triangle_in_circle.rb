# 4.4 6E
# 

require './geometric-constructions'

right_point = Point.new([1, 0]).with_name('right point')
origin = Point.new([0, 0])
circle = Circle.new(origin, right_point).with_name('original circle')

random_angle = 35.7 * Math::PI / 180
random_point = Point.new([Math.cos(random_angle), Math.sin(random_angle)]).with_name('random point on circle')

initial_layout = Layout.new([right_point, random_point], [], [circle])

left_up = Point.new([- 0.5, Math.sqrt(3.0) * 0.5])
left_down = Point.new([- 0.5, - Math.sqrt(3.0) * 0.5])

up_line = Line.new([left_up, right_point]).with_name('up line')
down_line = Line.new([left_down, right_point]).with_name('down line')

targets = [up_line, down_line]
filters = {4 => [up_line]}

steps = [:circle, :circle, :circle, :line, :line]

task = Task.new(initial_layout, targets, steps, filters)

solution_layout = task.solve
solution_layout.print(targets)

# Found a solution
# Layout has 15 points; 2 lines; 4 circles
# Point #0 is predefined. Coordinates: (1.0, 0.0)
# Point #1 is predefined. Coordinates: (0.8120835268918062, 0.5835412113561176)
# Circle #2 is centered at Point #1 and passes Point #0. Center: (0.8120835268918062, 0.5835412113561176). Radius: 0.6130521561958555
# Circle #3 is predefined. Center: (0.0, 0.0). Radius: 1.0
# Point #4 is intersection of Circle #2, Circle #3. Coordinates: (0.3189593092980698, 0.9477684100095858)
# Circle #5 is centered at Point #0 and passes Point #4. Center: (1.0, 0.0). Radius: 1.1670824227122352
# Point #6 is intersection of Circle #5, Circle #2. Coordinates: (1.0, 1.1670824227122352)
# Circle #7 is centered at Point #6 and passes Point #0. Center: (1.0, 1.1670824227122352). Radius: 1.1670824227122352
# Point #8 is intersection of Circle #7, Circle #5. Coordinates: (-0.010723026379084288, 0.5835412113561176)
# Line #9 passes Point #8, Point #0. Norm direction: 59.99999999999999. Distance to origin: 0.5
# Line #9 is a target
# Point #10 is intersection of Circle #7, Circle #5. Coordinates: (2.0107230263790843, 0.5835412113561176)
# Line #11 passes Point #0, Point #10. Norm direction: 300.00000000000006. Distance to origin: 0.5
# Line #11 is a target

# moves = [:circle, :line]

# step_count = 5
# generator_max = moves.length ** step_count


# (0..generator_max - 1).each do |generator|
#   steps = []
#   generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
#   generator_string.split('').each do |step_id|
#     steps << moves[step_id.to_i]
#   end
  
#   next if steps.select{|step| step == :line}.length < 2 # the solution requires aneed at least two lines in the solution because 

#   p [generator, steps]

#   task = Task.new(initial_layout, targets, steps, filters)

#   solution_layout = task.solve

#   if solution_layout.nil?
#   else
#     puts "*************Found solution*************"
#     p steps
#     solution_layout.print(targets)
#     exit
#   end
# end

