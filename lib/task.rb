class Task
  attr_reader :initial_layout, :targets, :moves

  def initialize(initial_layout, targets, moves)
    @initial_layout = initial_layout
    initial_layout.set_predefined
    @targets = targets
    @moves = moves
  end

  def solve
    layouts = [ initial_layout ]
    moves.each_with_index do |move, move_index|
      puts "Move #{move_index}: #{move}. Layout count: #{layouts.length}"
      new_layouts = []
      layouts.each do |layout|
        layout.each_outcome(move) do |outcome|
          new_layouts << outcome
          if outcome.contains?(targets)
            puts "Found a solution"
            return outcome
          end
        end
      end
      layouts = new_layouts
    end

    puts "Cannot find any layout containing targets"
    nil
  end
end
