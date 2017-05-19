require 'spec_helper'

RSpec.describe Justimmo::API::Mapper do
  module TestMapper
    extend Justimmo::API::Mapper
  end

  it 'has a main mapping' do
    expect(TestMapper.mapping?(:main)).to eq(true)
    expect(TestMapper.mapping?('main')).to eq(true)
  end

  it 'has other defined mappings' do
    expect(TestMapper.mapping?(:other)).to eq(true)
    expect(TestMapper.mapping?('other')).to eq(true)
    expect(TestMapper.mapping?(:nothing)).to eq(false)
    expect(TestMapper.mapping?('nothing')).to eq(false)
  end

  it 'has merged keys' do
    expect(TestMapper[:test]).to eq(:notest)
    expect(TestMapper[:alter]).to eq(:oida)
  end

  it 'can reverse map values' do
    expect(TestMapper[:oida, reverse: true]).to eq(:alter)
  end

  it 'can be accessed by strings or symbols' do
    expect(TestMapper[:alter]).to eq(:oida)
    expect(TestMapper['alter']).to eq(:oida)
    expect(TestMapper[:oida, reverse: true]).to eq(:alter)
    expect(TestMapper['oida', reverse: true]).to eq(:alter)
  end

  it 'handles key errors' do
    TestMapper.on_mapper_error(:raise)
    expect { TestMapper[:not_here] }.to raise_error(Justimmo::API::Mapper::KeyNotFound)
    expect { TestMapper[:alter] }.not_to raise_error

    TestMapper.on_mapper_error(:mark)
    expect { TestMapper[:not_here] }.not_to raise_error
    expect { TestMapper[:alter] }.not_to raise_error
    expect(TestMapper[:not_here]).to eq('!NOT_HERE')

    TestMapper.on_mapper_error(:convert)
    expect { TestMapper[:not_here] }.not_to raise_error
    expect { TestMapper[:alter] }.not_to raise_error
    expect(TestMapper[:not_here]).to eq(:not_here)
  end

  it 'handles mapper errors' do
    expect { TestMapper[:something, map: :nope] }.to raise_error(Justimmo::API::Mapper::MappingNotFound)
    expect { TestMapper[:other, map: :other] }.not_to raise_error
  end
end
