require 'spec_helper'
require 'xml_parser'

describe XmlParser do
  describe '#count_lines_by_speaker' do
    it 'it returns lines count by speaker' do
      filename = File.dirname(__FILE__) + '/test_files/test.xml'
      xml_parser = XmlParser.new(File.read(filename))
      expect(xml_parser.count_lines_by_speaker('OneLiner')).to be 1
      expect(xml_parser.count_lines_by_speaker('TwoLiner')).to be 2
      expect(xml_parser.count_lines_by_speaker('ThreeLiner')).to be 3
    end
  end

  describe '#speakers' do
    it 'returs all speakers in play' do
      filename = File.dirname(__FILE__) + '/test_files/test.xml'
      xml_parser = XmlParser.new(File.read(filename))
      expect(xml_parser.speakers).to eq ['OneLiner', 'TwoLiner', 'FourLiner', 'ThreeLiner']
    end
  end
end
