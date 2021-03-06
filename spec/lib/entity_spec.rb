require 'spec_helper'

describe Entity do
  it 'should set id' do
    point = Entity.new
    point.set_id
    expect(point.id).to eql 0

    line = Entity.new
    line.set_id
    expect(line.id).to eql 1
  end

  it 'should accept definition' do
    point = Entity.new
    point.definition[:is_intersection_of] = [1, 2]

    expect(point.definition[:is_intersection_of]).to eql [1, 2]
  end

  it 'should have name' do
    point = Entity.new.with_name('test point')

    expect(point.has_name?).to be true
    expect(point.name).to eql 'test point'
  end
end