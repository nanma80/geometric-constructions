require 'spec_helper'

describe Entity do
  it 'should accept id once' do
    point = Entity.new
    point.id = 3

    expect(point.id).to eql 3
    expect{ point.id = 4 }.to raise_error RuntimeError
  end

  it 'should accept definition once' do
    point = Entity.new
    point.definition = {:intersection => [1, 2]}

    expect(point.definition[:intersection]).to eql [1, 2]
    expect{ point.definition = {:intersection => [3, 4]} }.to raise_error RuntimeError
  end
end