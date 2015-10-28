require './geometric-constructions'

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
end
