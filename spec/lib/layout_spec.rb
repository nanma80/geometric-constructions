require 'spec_helper'

describe Layout do
  it 'should store entities' do
    layout = Layout.new
    layout.points << Point.new([1, 2])
    layout.circles << Circle.new(Point.new([1, 2]), Point.new([1, 1]))

    expect(layout.points.length).to eq 1
    expect(layout.circles.length).to eq 1
  end

  it 'should duplicate' do
    layout1 = Layout.new
    layout1.points << Point.new([1, 2])
    layout1.circles << Circle.new(Point.new([1, 2]), Point.new([1, 1]))

    layout2 = layout1.dup
    expect(layout2.points.length).to eq 1
    expect(layout2.circles.length).to eq 1

    layout1.points << Point.new([2, 3])
    expect(layout1.points.length).to eq 2
    expect(layout2.points.length).to eq 1
  end
end