require "spec_helper"

describe "JustimmoClient::OptionParser" do
  let(:parser) do
    JustimmoClient::OptionParser.new do |options|
      options.add :a
      options.add :b
      options.add :c
      options.add :yes, type: :bool
      options.add :no, type: :bool
      options.add :order, values: %i[asc desc]
      options.group :numbers do |nums|
        nums.add :one
        nums.add :two
        nums.add :three
      end
    end
  end

  let(:parser_ger) do
    JustimmoClient::OptionParser.new do |options|
      options.mappings = { price: :preis, type: :art, asc: :auf, order: :sortierung }
      options.range_suffix = %i[_von _bis]

      options.add :price
      options.add :type_id
      options.add :type_min, as: :objart_von
      options.add :order, values: %i[asc desc]
      options.group :filter do |f|
        f.add :price_min
        f.add :price_max
      end
    end
  end

  let(:example1) do
    { a: "a", b: "b", one: 1, two: 2 }
  end

  let(:example2) do
    { type_id: 1, price: 100.0, price_min: 100.0, price_max: 1000 }
  end

  it "only accepts defined options" do
    expect { parser.parse(not_defined: 1) }.to raise_exception(JustimmoClient::InvalidOption)
  end

  it "groups specific options" do
    expect(parser.parse(example1)).to eq({a: "a", b: "b", numbers: { one: 1, two: 2}})
  end

  it "translates with suffix" do
    expect(parser_ger.parse(example2)).to eq({
      art_id: 1,
      preis: 100.0,
      filter: {
        preis_von: 100.0,
        preis_bis: 1000.0
      }
    })
  end

  it "can convert booleans" do
    expect(parser.parse(yes: true, no: false)).to eq({ yes: 1, no: 0 })
  end

  it "can override translations locally" do
    expect(parser_ger.parse(type_id: 1, type_min: 10)).to eq({art_id: 1, objart_von: 10})
  end

  it "can set a constraint for values" do
    expect(parser.parse(order: :asc)).to eq({ order: :asc })
    expect { parser.parse(order: :none) }.to raise_exception(JustimmoClient::InvalidValue)
  end

  it "can translate values" do
    expect(parser_ger.parse(order: :asc)).to eq({ sortierung: :auf})
  end
end
