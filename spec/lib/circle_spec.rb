require 'spec_helper'

describe Circle do
  it 'should compute radius' do
    c1 = Circle.new(Point.new([1, 0]), Point.new([1, 2]))
    expect(c1.center).to eq Point.new([1, 0])
    expect(c1.radius).to eq 2.0
  end

  it 'should check for equality' do
    c1 = Circle.new(Point.new([1, 0]), Point.new([1, 2]))
    c2 = Circle.new(Point.new([1, 0]), Point.new([-1, 0]))
    c3 = Circle.new(Point.new([0, 0]), Point.new([-1, 0]))
    expect(c1).to eq c2
    expect(c1).not_to eq c3
  end

  it 'should find no intersection with a circle' do
    c1 = Circle.new(Point.new([3, 0]), Point.new([3, 0.75]))
    c2 = Circle.new(Point.new([1, 0]), Point.new([0, 0.25]))

    expect(c2.intersection_with_circle(c1)).to eq []
  end

  it 'should find tangent point between two circles' do
    c1 = Circle.new(Point.new([1, 1]), Point.new([1, 1 + Math.sqrt(0.5)]))
    c2 = Circle.new(Point.new([0, 0]), Point.new([0, Math.sqrt(0.5)]))

    expect(c1.intersection_with_circle(c2)).to eq [Point.new([0.5, 0.5])]
  end

  it 'should find two intersections between two circles' do
    c1 = Circle.new(Point.new([1, 1]), Point.new([0, 1]))
    c2 = Circle.new(Point.new([0, 0]), Point.new([1, 0]))

    p1 = Point.new([0, 1])
    p2 = Point.new([1, 0])
    
    expect(c1.intersection_with_circle(c2).sort{|point| point.x}).to eq [p1, p2]
  end

  it 'should find two intersections between two circles - example 2' do
    c1 = Circle.new(Point.new([0, 6]), Point.new([0, 1]))
    c2 = Circle.new(Point.new([0, 0]), Point.new([0, 5]))

    p1 = Point.new([-4, 3])
    p2 = Point.new([4, 3])
    
    expect(c1.intersection_with_circle(c2).sort{|point| point.x}).to eq [p1, p2]
  end

  it 'should construct a circle using a non-collapsing compass' do
    p1 = Point.new([1, 2])
    p2 = Point.new([4, -2])
    center = Point.new([0, 1])
    circle = Circle.new(center, [p1, p2])

    target = Circle.new(center, Point.new([5, 1]))
    expect(circle).to eq target
  end
end
