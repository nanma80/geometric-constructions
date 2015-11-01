require 'spec_helper'

describe Point do
  it 'should use real coordinates' do
    point = Point.new([1, 0])
    expect(point.coordinates.first).to eql 1.0
    expect(point.coordinates.last).to eql 0.0
  end

  it 'should check for equality' do
    point1 = Point.new([1, 0])
    point2 = Point.new([2/2, 1-1])
    point3 = Point.new([1.00001, 0])

    expect(point1).to eq point2
    expect(point1).not_to eq point3
  end

  it 'should check if it is new in a layout' do
    layout = Layout.new([Point.new([1, 2]), Point.new([2, 3]), Point.new([3, 4])])
    old_point = Point.new([4.0/2, 1.0 + 2.0])
    expect(old_point.is_new?(layout)).to be false

    new_point = Point.new([4, 5])
    expect(new_point.is_new?(layout)).to be true
  end
end
