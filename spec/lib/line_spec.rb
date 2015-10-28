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
end
