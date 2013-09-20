require 'spec_helper'
require 'xml_parser'

describe XmlParser do
  describe '#initialize' do
    it 'instantiates @doc with Nokogiri XML parser' do
      doc = XmlParser.new(nil).instance_variable_get(:@doc)
      expect(doc.instance_of?(Nokogiri::XML::Document)).to be true
    end
  end

  describe '#speakers_sorted_by_line_count' do
    it 'returns hash of speakers with line count sorted by line count' do
      filename = File.dirname(__FILE__) + '/test_files/test.xml'
      xml_parser = XmlParser.new(File.read(filename))
      expect(xml_parser.speakers_sorted_by_line_count.to_a).to eq({'FourLiner' => 4, 'ThreeLiner' => 3, 'TwoLiner' => 2, 'Liner' => 1}.to_a)
    end
  end
end
