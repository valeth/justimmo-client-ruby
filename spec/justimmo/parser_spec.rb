require 'spec_helper'

RSpec.describe Justimmo::Parser do
  it 'handles empty strings' do
    expect(Justimmo::Parser.parse('')).to eq({})
  end

  it 'handles non-string objects' do
    expect(Justimmo::Parser.parse(1)).to eq({})
    expect(Justimmo::Parser.parse(false)).to eq({})
  end

  it 'handles empty XML documents' do
    xml = <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
    XML

    expect(Justimmo::Parser.parse(xml)).to eq({})
  end

  it 'handles invalid XML documents' do
    xml = <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <foo>
        <bar >x</bar>
      </notfoo>
    XML

    expect(Justimmo::Parser.parse(xml)).to eq({})
  end

  it 'parses XML documents' do
    xml = <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <foo>
        <stringy>hello</stringy>
        <floaty>1.2</floaty>
        <justone>1</justone>
        <true>true</true>
        <false>false</false>
        <date>2017-01-21 23:12:01</date>
        <empty />

        <bar ichi="1" />

        <baz>foobar!</baz>
        <baz ichi="1" ni="2" san="3" >one to three</baz>
        <baz yon="4" go="5" roku="6" />
        <baz nana="7">
          <more-nesting>
            <p>oi</p>
          </more-nesting>
        </baz>
      </foo>
    XML

    hash = {
      foo: {
        stringy: 'hello',
        floaty: 1.2,
        justone: 1,
        empty: nil,
        true: true,
        false: false,
        date: '2017-01-21 23:12:01'.to_date,
        bar: { :@ichi => 1 },
        baz: [
          'foobar!',
          { :@ichi => 1, :@ni => 2, :@san => 3, value: 'one to three' },
          { :@yon => 4, :@go => 5, :@roku => 6 },
          { :@nana => 7, more_nesting: { p: 'oi' } }
        ]
      }
    }.freeze

    expect(Justimmo::Parser.parse(xml)).to eq(hash)
  end
end
