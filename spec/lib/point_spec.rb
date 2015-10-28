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
end
