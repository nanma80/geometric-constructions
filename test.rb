# Trying to solve 3 degrees in 6L
require './geometric-constructions'

origin = Point.new([0, 0])
right_point = Point.new([1, 0])
horizontal_line = Line.new([origin, right_point])

circle = Circle.new(origin, right_point)
left_vertical_line = Line.perp_bis([origin, right_point])

golden_section = (1 - (Math.sqrt(5) - 1)/2)

right_vertical_line = Line.perp_bis([right_point, Point.new([golden_section, 0])])

initial_layout = Layout.new([origin, right_point], [horizontal_line], [circle])
initial_layout.add_entity(left_vertical_line)

targets = [right_vertical_line]

# steps = [:compass, :compass, :perp_bis] # original

first_moves = [:line, :circle, :perp_bis, :perp, :parallel, :compass]
second_moves = [:line, :perp_bis, :perp, :parallel]

first_moves.each do |first_move|
  second_moves.each do |second_move|
    steps = [first_move, second_move]

    task = Task.new(initial_layout, targets, steps)

    solution_layout = task.solve

    if not solution_layout.nil?
      p steps

      solution_layout.print(targets)
      exit
    end
  end
end


