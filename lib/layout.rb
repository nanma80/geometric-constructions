require 'pp'

class Layout
  attr_reader :points, :lines, :circles
  SORTING_FACTOR = Math::E

  def initialize(points = nil, lines = nil, circles = nil)
    @points = points || []
    @lines = lines || []
    @circles = circles || []
  end

  def add_point(point)
    @points << point
    @points.sort_by! { |pt| pt.x * SORTING_FACTOR + pt.y }
  end

  def add_line(line)
    @lines << line
    @lines.sort_by! { |l| l.norm_direction * SORTING_FACTOR + l.origin_distance }
  end

  def add_circle(circle)
    @circles << circle
    @circles.sort_by! { |c| c.radius * SORTING_FACTOR * SORTING_FACTOR + c.center.x * SORTING_FACTOR + c.center.y }
  end

  def is_new?(layouts)
    layouts.each do |layout|
      if layout == self
        return false
      end
    end
    true
  end

  def ==(that)
    unless that.is_a?(Layout)
      raise "Comparing #{that.inspect} to a layout"
    end

    [
      [points, that.points],
      [lines, that.lines],
      [circles, that.circles]
    ].each do |pair|
      if pair[0].length != pair[1].length
        return false
      end

      pair[0].each_with_index do |entity, index|
        that_entity = pair[1][index]
        unless entity == that_entity
          return false
        end
      end
    end

    true
  end

  def set_predefined
    [@points, @lines, @circles].each do |group|
      group.each do |entity|
        entity.definition[:is_predefined] = []
      end
    end
  end

  def dup
    Layout.new(points.dup, lines.dup, circles.dup)
  end

  def contains?(targets)
    targets.each do |target|
      if target.is_new?(self)
        return false
      end
    end
    true
  end

  def print(targets)
    puts "Layout has #{points.length} points; #{lines.length} lines; #{circles.length} circles"
    targets.each do |target|
      target_in_layout = target.find_same(self)
      target_in_layout.print
      puts "#{target_in_layout.class} \##{target_in_layout.id} is a target"
    end
  end

  def add_entity(new_entity)
    lines.each do |line|
      new_entity.intersection_with_line(line).each do |point|
        next unless point.is_new?(self)
        add_point(point)
      end
    end

    circles.each do |circle|
      new_entity.intersection_with_circle(circle).each do |point|
        next unless point.is_new?(self)
        add_point(point)
      end
    end

    if new_entity.is_a?(Circle)
      add_circle(new_entity)
    elsif new_entity.is_a?(Line)
      add_line(new_entity)
    else
      raise "Cannot add #{new_entity.inspect} to layout"
    end
  end

  def each_outcome(move)
    case move
    when :circle
      @points.permutation(2).each do |points|
        dup_layout = dup
        new_circle = Circle.new(points[0], points[1])
        next unless new_circle.is_new?(dup_layout)
        dup_layout.add_entity(new_circle)
        yield dup_layout
      end
    when :line
      @points.permutation(2).each do |points|
        dup_layout = dup
        new_line = Line.new(points)
        next unless new_line.is_new?(dup_layout)
        dup_layout.add_entity(new_line)
        yield dup_layout
      end
    else
      raise "#{move} is not supported"
    end
  end
end
