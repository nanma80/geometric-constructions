# Attempting 11.2 in 5L
require './geometric-constructions'

left_point = Point.new([-1, 0]).with_name('left point')
right_point = Point.new([1, 0]).with_name('right_point')
horizontal_line = LineSegment.new([left_point, right_point])

top_x = -0.71
top_y = 2.73

top_point = Point.new([top_x , top_y ]).with_name('top')
center = Point.new([top_x / 3.0, top_y / 3.0]).with_name('center')

left_line = Line.new([left_point, top_point]).with_name('left line')
right_line = Line.new([right_point, top_point]).with_name('right line')

targets = [right_line]

l_moves = [:circle, :line, :perp_bis, :perp, :parallel, :angle_bis, :compass]
line_moves = [:line, :perp_bis, :perp, :parallel, :angle_bis]

initial_layout = Layout.new([left_point, right_point, center], [horizontal_line], [])

step_count = 4
generator_max = l_moves.length ** step_count

# 292 2800/7284
# 299 800/2194

(825..(generator_max - 1)).each do |generator|
  steps = []
  generator_string = (generator + generator_max).to_s(l_moves.length)[1..step_count]
  generator_string.split('').each do |step_id|
    steps << l_moves[step_id.to_i]
  end
  Logger.log "\e[33m#{[generator, steps].inspect}\e[0m"
  next unless line_moves.include? steps.last

  task = Task.new(initial_layout, targets, steps)

  solution_layout = task.solve

  unless solution_layout.nil?
    puts "\# ************* Found partial solution *************"
    puts '# ' + steps.inspect
    solution_layout.print(targets)
    extended_targets = [right_line, left_line]
    filters = {4 => targets}

    line_moves.each do |line_move|
      extended_steps = steps + [line_move]
      Logger.log "\e[33m#{extended_steps}\e[0m"

      extended_task = Task.new(initial_layout, extended_targets, extended_steps, filters)
      solution_layout = extended_task.solve

      unless solution_layout.nil?
        puts "\# ************* Found full solution *************"
        puts '# ' + extended_steps.inspect
        solution_layout.print(targets)
        exit
      end
    end
  end
end
