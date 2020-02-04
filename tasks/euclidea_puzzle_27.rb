
require './geometric-constructions'


point_1 = Point.new([0, 0]).with_name('point 1')
point_2 = Point.new([2, 1]).with_name('point 2')
point_3 = Point.new([2, 0]).with_name('target point')

line_12 = LineSegment.new([point_1, point_2]).with_name('line 12')
line_13 = LineSegment.new([point_1, point_3]).with_name('line 13')
line_23 = LineSegment.new([point_2, point_3]).with_name('line 23')

initial_layout = Layout.new([point_1, point_2], [line_12], [])

# targets = [point_3, line_23]
targets = [point_3]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
e_moves = [:line, :circle]

step_count = 6
moves = [:line, :circle]
generator_max = moves.length ** step_count

filters = {}

(0..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << moves[step_id.to_i]
  end

  # next unless steps[1] == :line

  p [generator, steps]

  layout = initial_layout.dup
  
  task = Task.new(layout, targets, steps, filters)

    solution_layout = task.solve

    if solution_layout.nil?
    else
      puts "\# *************Found solution*************"
      puts '# ' + steps.inspect
      solution_layout.print(targets)
      exit
    end
end

puts "No solution found"

