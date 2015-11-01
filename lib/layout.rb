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

  def each_outcome(move)
    case move
    when :circle
      @points.permutation(2).each do |points|
        dup_layout = dup
        new_circle = Circle.new(points[0], points[1])
        next unless new_circle.is_new?(dup_layout)

        dup_layout.lines.each do |line|
          line.intersection_with_circle(new_circle).each do |point|
            next unless point.is_new?(dup_layout)
            dup_layout.points << point
          end
        end

        dup_layout.circles.each do |circle|
          circle.intersection_with_circle(new_circle).each do |point|
            next unless point.is_new?(dup_layout)
            dup_layout.points << point
          end
        end

        dup_layout.circles << new_circle
        yield dup_layout
      end
    when :line
      @points.permutation(2).each do |points|
        dup_layout = dup
        new_line = Line.new(points)
        next unless new_line.is_new?(dup_layout)

        dup_layout.lines.each do |line|
          line.intersection_with_line(new_line).each do |point|
            next unless point.is_new?(dup_layout)
            dup_layout.points << point
          end
        end

        dup_layout.circles.each do |circle|
          circle.intersection_with_line(new_line).each do |point|
            next unless point.is_new?(dup_layout)
            dup_layout.points << point
          end
        end

        dup_layout.lines << new_line
        yield dup_layout
      end
    else
      raise "#{move} is not supported"
    end
  end
end
