require_relative '../lib/xml_parser'
require 'rspec'
require 'webmock/rspec'

describe XmlParser do
  
  let(:xml_doc) { File.dirname(__FILE__) + '/fixtures/sample.xml' }
    
  before do
    # stub_request(:get, XmlParser::REMOTE_XML_URL).to_return(:body => xml_doc, :status => 200)
  end
  
  describe '.new' do
    it "should call Nokogiri::XML open to parse remote XML file" do
      parser = XmlParser.new(xml_doc)
      parser.doc.should_not be_nil
      parser.doc.is_a?(Nokogiri::XML::Document).should be_true
    end
    
    it "should initialize speech_count instance variable with empty hash" do
      parser = XmlParser.new(xml_doc)
      parser.speech_count.should == {}
    end
  end
  
  describe '#count_lines' do
    it "should count # of LINE children given the XML element" do
      element = double()
      node_set = double()
      element.should_receive(:xpath).with(".//LINE").and_return(node_set)
      node_set.should_receive(:count).and_return(5)

      parser = XmlParser.new(xml_doc)
      count = parser.count_lines(element)
      count.should == 5      
    end
  end
  
  describe '#parse_speeches' do
    before do
      @parser = XmlParser.new(xml_doc)
    end
    it "should get nodes with SPEECH name and iterate through them" do
      @parser.parse_speeches
      @parser.speech_count.should_not == {}
    end
  end
  
end