require 'rspec'
require_relative 'shakespeare_analyzer'

describe LinesParser do
  def parse(xml)
    LinesParser.new(xml).parse
  end

  def stat(speaker, lines_count)
    SpeakerStats.new(speaker, lines_count)
  end

  it 'returns empty result for empty input' do
    expect(parse('')).to be_empty
  end

  it 'parses speaker name' do
    xml = <<XML
      <SPEECH>
        <SPEAKER>MALCOLM</SPEAKER>
      </SPEECH>
XML
    expect(parse(xml)).to eq([stat('MALCOLM', 0)])
  end

  it 'parses multiple speaker names and speeches' do
    xml = <<XML
      <ACT>
      <SPEECH>
        <SPEAKER>adam</SPEAKER>
        <SPEAKER>josh</SPEAKER>
      </SPEECH>
      <SPEECH>
        <SPEAKER>van der sar</SPEAKER>
      </SPEECH>
      </ACT>
XML
    expected = ['adam', 'josh', 'van der sar'].map { |name| stat(name, 0) }

    expect(parse(xml)).to eq(expected)
  end

  it 'counts lines for speaker' do
    xml = <<XML
      <ACT>
      <SPEECH>
        <SPEAKER>Guy</SPEAKER>
        <LINE>line 1</LINE>
        <LINE>line 2</LINE>
      </SPEECH>
      <SPEECH>
        <SPEAKER>Guy</SPEAKER>
        <LINE>last line</LINE>
      </SPEECH>
      </ACT>
XML
    expect(parse(xml)).to eq([stat('Guy', 3)])
  end

  it 'enables multiple speakers per speech' do
    xml = <<XML
      <ACT><SPEECH>
        <SPEAKER>Guy</SPEAKER>
        <SPEAKER>Robot</SPEAKER>
        <LINE>line 1</LINE>
        <LINE>line 2</LINE>
        <LINE>XD</LINE>
      </ACT></SPEECH>
XML

    expect(parse(xml)).to eq([stat('Guy', 3), stat('Robot', 3)])
  end

  it 'returns speakers ordered by descending line count' do
    xml = <<XML
      <ACT>
      <SPEECH>
        <SPEAKER>Guy</SPEAKER>
        <SPEAKER>Robot</SPEAKER>
        <LINE>line 1</LINE>
        <LINE>line 2</LINE>
      </SPEECH>
      <SPEECH>
        <SPEAKER>Robot</SPEAKER>
        <LINE>last line</LINE>
      </SPEECH>
      <SPEECH>
        <SPEAKER>Someone</SPEAKER>
        <LINE>only one</LINE>
      </SPEECH>
      </ACT>
XML
    expected = [['Robot', 3], ['Guy', 2], ['Someone', 1]].map { |args| stat(*args) }

    expect(parse(xml)).to eq(expected)
  end

  it 'ignores other tags' do
    xml = <<XML
      <LUL>
      <Woot />
      <LMAO>
      <SPEECH>
        <ROTFL />
        <SPEAKER>Someone</SPEAKER>
        <STAGEDIR>x y z</STAGEDIR>
        <LINE>only one</LINE>
      </SPEECH>
      </LMAO>
      </LUL>
XML

    expect(parse(xml)).to eq([stat('Someone', 1)])
  end
end


describe StatsPrinter do
  it 'prints to supplied IO object' do
    mock_io = double('io', :puts => nil)
    stats = [SpeakerStats.new('John', 83), SpeakerStats.new('Anna', 5)]

    expect(mock_io).to receive(:puts).with('83 John').ordered
    expect(mock_io).to receive(:puts).with('5 Anna').ordered

    printer = StatsPrinter.new(stats , mock_io)
    printer.print
  end

  it 'capitalizes speaker names' do
    mock_io = double('io', :puts => nil)
    stats = [SpeakerStats.new('OLD Guy f tHE fOrEsT', 3)]

    expect(mock_io).to receive(:puts).with('3 Old Guy F The Forest')

    printer = StatsPrinter.new(stats, mock_io)
    printer.print
  end
end

