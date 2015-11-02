require 'spec_helper'

describe Line do
  it 'should compute normal form' do
    p1 = Point.new([-2, 0])
    p2 = Point.new([0, 2])
    p3 = Point.new([0, 0])
    p4 = Point.new([-2, 2])
    
    l1 = Line.new([p1, p2])
    l2 = Line.new([p1, p3])
    l3 = Line.new([p2, p3])
    l4 = Line.new([p2, p4])

    expect(Point.new(l1.normal_form)).to eq Point.new([Math::PI * 3 / 4, Math.sqrt(2)])
    expect(Point.new(l2.normal_form)).to eq Point.new([Math::PI / 2, 0])
    expect(Point.new(l3.normal_form)).to eq Point.new([0, 0])
    expect(Point.new(l4.normal_form)).to eq Point.new([Math::PI / 2, 2])
  end

  it 'should check for equality' do
    l1 = Line.new([Point.new([0, 1]), Point.new([2, -1])])
    l2 = Line.new([Point.new([3, -2]), Point.new([1, 0])])
    l3 = Line.new([Point.new([1, -2]), Point.new([1, 0])])

    expect(l1).to eq l2
    expect(l1).not_to eq l3
  end

  it 'should store definition' do
    p1 = Point.new([-2, 0])
    p2 = Point.new([0, 2])
    l1 = Line.new([p1, p2])

    expect(l1.definition[:passes]).to eq [p1, p2]
  end

  it 'should not find intersection with itself' do
    p1 = Point.new([-2, 0])
    p2 = Point.new([0, 2])
    l1 = Line.new([p1, p2])
    l2 = Line.new([p2, p1])

    expect{ l1.intersection_with_line(l2) }.to raise_error RuntimeError
  end

  it 'should find no intersection with a circle' do
    l1 = Line.new([Point.new([1, 0]), Point.new([0, 1])])
    c1 = Circle.new(Point.new([3, 0]), Point.new([3, 0.75]))
    expect(l1.intersection_with_circle(c1)).to eq []
  end

  it 'should find tangent point between a line and a circle' do
    l1 = Line.new([Point.new([1, 0]), Point.new([0, 1])])
    c1 = Circle.new(Point.new([1, 1]), Point.new([1, 1 + Math.sqrt(0.5)]))
    expect(l1.intersection_with_circle(c1)).to eq [Point.new([0.5, 0.5])]
  end

  it 'should find intersections between a line and a circle' do
    l1 = Line.new([Point.new([1, 0]), Point.new([-1, 2])])
    c1 = Circle.new(Point.new([1, 1]), Point.new([1, 2]))
    p1 = Point.new([0, 1])
    p2 = Point.new([1, 0])
    
    expect(l1.intersection_with_circle(c1).sort{|point| point.x}).to eq [p1, p2]
    expect(c1.intersection_with_line(l1).sort{|point| point.x}).to eq [p1, p2]
  end

  it 'should find empty intersection for parallel lines' do
    l1 = Line.new([Point.new([1, 0]), Point.new([0, 1])])
    l2 = Line.new([Point.new([-1, 0]), Point.new([0, -1])])
    l3 = Line.new([Point.new([2, 0]), Point.new([0, 2])])
    l4 = Line.new([Point.new([-1, 1]), Point.new([1, -1])])

    expect(l1.intersection_with_line(l2)).to eq []
    expect(l1.intersection_with_line(l3)).to eq []
    expect(l1.intersection_with_line(l4)).to eq []
    expect(l4.intersection_with_line(l2)).to eq []
  end

  it 'should find intersection with a line' do
    l1 = Line.new([Point.new([1, 0]), Point.new([0, 1])])
    l2 = Line.new([Point.new([0, 0]), Point.new([1, 1])])
    l3 = Line.new([Point.new([-1, 0]), Point.new([3, 0])])

    expect(l1.intersection_with_line(l2)).to eq [Point.new([0.5, 0.5])]
    expect(l1.intersection_with_line(l3)).to eq [Point.new([1, 0])]
    expect(l3.intersection_with_line(l2)).to eq [Point.new([0, 0])]
  end

  it 'should find complicated intersection with a line' do
    l1 = Line.new([Point.new([2, 0]), Point.new([0, 4])])
    l2 = Line.new([Point.new([0, 0]), Point.new([0.5, 1])])

    expect(l1.intersection_with_line(l2)).to eq [Point.new([1, 2])]
  end

  it 'should create perpendicular bisector' do
    l1 = Line.perp_bis([Point.new([0, 0]), Point.new([1, 1])])
    l2 = Line.new([Point.new([1, 0]), Point.new([0, 1])])

    expect(l1).to eq l2
  end
end
