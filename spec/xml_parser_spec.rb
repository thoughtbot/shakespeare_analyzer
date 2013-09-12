require 'spec_helper'
require 'xml_parser'

describe XmlParser do
  describe '#lines_by_speaker' do
    it 'it returns lines count by speaker' do
      filename = File.dirname(__FILE__) + '/test_files/test.xml'
      xml_parser = XmlParser.new(File.read(filename))
      expect(xml_parser.lines_by_speaker('OneLiner')).to be 1
      expect(xml_parser.lines_by_speaker('TwoLiner')).to be 2
      expect(xml_parser.lines_by_speaker('ThreeLiner')).to be 3
    end
  end
end
