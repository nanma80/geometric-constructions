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
    moves.each do |move|
      new_layouts = []
      layouts.each do |layout|
        layout.each_outcome(move) do |outcome|
          new_layouts << outcome
        end
      end
      layouts = new_layouts
    end

    layouts.each do |layout|
      if layout.contains?(targets)
        return layout
      end
    end

    puts "Cannot find any layout containing targets"
    nil
  end
end
