class Task
  attr_reader :initial_layout, :targets, :moves

  def initialize(initial_layout, targets, moves, filters = nil)
    @initial_layout = initial_layout
    initial_layout.set_predefined
    @targets = targets
    @moves = moves
    @filters = filters || {}
  end

  def solve
    layouts = [ initial_layout ]
    moves.each_with_index do |move, move_index|
      if @filters.has_key?(move_index)
        puts "Filtering layouts before Move #{move_index}: #{move}. Before count: #{layouts.length}" if verbose
        filtered_layouts = []
        filter_entities = @filters[move_index]
        layouts.each_with_index do |layout, layout_index|
          if layout.contains?(filter_entities)
            filtered_layouts << layout
          end
        end
        layouts = filtered_layouts
        puts "Filtering layouts before Move #{move_index}: #{move}. After count: #{layouts.length}" if verbose
      end

      is_last_move = (move_index == moves.length - 1)
      is_last_but_one_move = (move_index == moves.length - 2)
      puts "Move #{move_index}: #{move}. Layout count: #{layouts.length}" if verbose
      new_layouts = []
      layouts.each_with_index do |layout, layout_index|
        if layout_index % 100 == 0
          puts "Processed #{layout_index}/#{layouts.length} layouts in this round" if verbose
        end
        layout.each_outcome(move) do |outcome|
          unless is_last_move
            if (!is_last_but_one_move) || (is_last_but_one_move && Random.rand < 0.02)
              new_layouts << outcome
            end
          end
          
          if outcome.contains?(targets)
            puts "Found a solution" if verbose
            return outcome
          end
        end
      end
      layouts = new_layouts.shuffle
    end

    puts "Cannot find any layout containing targets" if verbose
    nil
  end

  def verbose
    !ENV['_'].include?('rspec')
  end
end
