class Task
  attr_reader :initial_layout, :targets, :moves

  def initialize(initial_layout, targets, moves, filters = nil)
    @initial_layout = initial_layout
    initial_layout.set_predefined
    @targets = targets
    @moves = moves
    @filters = filters || {}
  end

  def solve(options = nil)
    options ||= {}
    subsample_rate = options[:subsample_rate] || 1.0
    layouts = [ initial_layout ]
    moves.each_with_index do |move, move_index|
      if @filters.has_key?(move_index)
        Logger.log "Filtering layouts before Move #{move_index}: #{move}. Before count: #{layouts.length}"
        filtered_layouts = []
        filter_entities = @filters[move_index]
        layouts.each_with_index do |layout, layout_index|
          if layout.contains?(filter_entities)
            filtered_layouts << layout
          end
        end
        layouts = filtered_layouts
        Logger.log "Filtering layouts before Move #{move_index}: #{move}. After count: #{layouts.length}"
      end

      is_last_move = (move_index == moves.length - 1)
      is_last_but_one_move = (move_index == moves.length - 2)
      Logger.log "Move #{move_index}: #{move}. Layout count: #{layouts.length}"
      new_layouts = []
      layouts.each_with_index do |layout, layout_index|
        if layout_index % 10 == 0
          Logger.log "Processed #{layout_index}/#{layouts.length} layouts in this round"
        end
        layout.each_outcome(move) do |outcome|
          unless is_last_move
            if (!is_last_but_one_move) || (is_last_but_one_move && Random.rand <= subsample_rate)
              new_layouts << outcome
            end
          end
          
          if outcome.contains?(targets)
            Logger.log "Found a solution"
            return outcome
          end
        end
      end
      layouts = new_layouts.shuffle
    end

    Logger.log "Cannot find any layout containing targets"
    nil
  end
end
