require 'pp'

class Layout
  attr_reader :points, :lines, :circles

  def initialize(points = nil, lines = nil, circles = nil)
    @points = points || []
    @lines = lines || []
    @circles = circles || []
  end

  def set_predefined
    [@points, @lines, @circles].each do |group|
      group.each do |entity|
        entity.definition[:predefined] = true
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
    puts self
    puts "Layout has #{points.length} points; #{lines.length} lines; #{circles.length} circles"
    targets.each do |target|
      target_in_layout = target.find_same(self)
      pp target_in_layout.definition
    end
  end

  def add_entity(new_entity)
    lines.each do |line|
      new_entity.intersection_with_line(line).each do |point|
        next unless point.is_new?(self)
        points << point
      end
    end

    circles.each do |circle|
      new_entity.intersection_with_circle(circle).each do |point|
        next unless point.is_new?(self)
        points << point
      end
    end

    if new_entity.is_a?(Circle)
      circles << new_entity
    elsif new_entity.is_a?(Line)
      lines << new_entity
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
