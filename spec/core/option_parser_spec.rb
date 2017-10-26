require "spec_helper"

describe JustimmoClient::OptionParser do
  let(:parser) do
    JustimmoClient::OptionParser.new do |options|
      options.add :a
      options.add :b
      options.add :c
      options.add :yes, type: :bool
      options.add :no,  type: :bool
      options.add :price
      options.add :type_id
      options.add :order, values: %i[asc desc]
      options.group :numbers do |g|
        g.add :one
        g.add :two
        g.add :three
      end
      options.group :filter do |g|
        g.add :price_min
        g.add :price_max
      end
    end
  end

  context "parsing" do
    let(:example) do
      { a: "a", b: "b", one: 1, two: 2 }
    end

    it "only accepts defined options" do
      expect { parser.parse(not_defined: 1) }
        .to raise_exception(described_class::InvalidOption)
    end

    it "can parse an empty hash" do
      expect(parser.parse({})).to eq({})
    end

    it "removes nil values" do
      expect(parser.parse(a: nil, b: "B", c: nil, one: 1, two: nil ))
        .to eq({ b: "B", numbers: { one: 1 } })
    end

    it "groups specific options" do
      expect(parser.parse(example))
        .to eq({a: "a", b: "b", numbers: { one: 1, two: 2}})
    end

    it "raises an exceptition if a key is already grouped" do
      expect do
        parser.group :numbers2 do |g|
          g.add :one
        end
      end
        .to raise_exception(described_class::DuplicateKeyGroup)
    end

    it "can convert booleans" do
      expect(parser.parse(yes: true, no: false))
        .to eq({ yes: 1, no: 0 })
    end

    it "can set a constraint for values" do
      expect(parser.parse(order: :asc))
        .to eq({ order: :asc })

      expect { parser.parse(order: :none) }
        .to raise_exception(described_class::InvalidValue)
    end
  end

  context "mapping" do
    let(:example) do
      { type_id: 1, price: 100.0, price_min: 100.0, price_max: 1000 }
    end

    before do
      parser.mappings = {
        price: :preis,
        type:  :art,
        asc:   :auf,
        order: :sortierung
      }
    end

    it "can translate values" do
      expect(parser.parse(order: :asc))
        .to eq({ sortierung: :auf})
    end

    before do
      parser.range_suffix = %i[_von _bis]
    end

    it "translates with suffix" do
      expect(parser.parse(example)).to eq({
        art_id: 1,
        preis: 100.0,
        filter: {
          preis_von: 100.0,
          preis_bis: 1000.0
        }
      })
    end

    before do
      parser.add :type_min, as: :objart_von
    end

    it "can override translations locally" do
      expect(parser.parse(type_id: 1, type_min: 10))
        .to eq({art_id: 1, objart_von: 10})
    end
  end
end
