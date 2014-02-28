require_relative '../lib/xml_parser'
require 'rspec'
require 'webmock/rspec'

describe XmlParser do
  
  let(:xml_doc) { File.dirname(__FILE__) + '/fixtures/sample.xml' }
  
  describe '.new' do
    it "should call Nokogiri::XML open to parse remote XML file" do
      parsed = XmlParser.new(xml_doc)
      parsed.doc.should_not be_nil
      parsed.doc.is_a?(Nokogiri::XML::Document).should be_true
    end
    
    it "should initialize speech_count instance variable with empty hash" do
      parsed = XmlParser.new(xml_doc)
      parsed.speech_count.should == {}
    end
  end
  
  describe '#count_lines' do
    it "should count # of LINE children given the XML element" do
      element = double()
      node_set = double()
      element.should_receive(:xpath).with(".//LINE").and_return(node_set)
      node_set.should_receive(:count).and_return(5)

      parsed = XmlParser.new(xml_doc)
      count = parsed.count_lines(element)
      count.should == 5      
    end
  end
  
  describe '#parse_speeches' do
    it "should get nodes with SPEECH name and iterate through them" do
      parsed = XmlParser.new(xml_doc)
      parsed.parse_speeches
      parsed.speech_count.should_not == {}
    end
  end
  
  describe '#sort_speech_count' do
    it "should returned speech_count hash sorted by speech count" do
      parsed = XmlParser.new(xml_doc)
      parsed.parse_speeches
      result = parsed.sort_speech_count
      result[0][1].should > result[-1][1]
    end
  end
  
  describe "#print_result" do    
    it "should print results" do
      STDOUT.should_receive(:puts).with("543 Macbeth")
      STDOUT.should_receive(:puts).with("345 Banquo")
      STDOUT.should_receive(:puts).with("220 Duncan")
      
      parsed = XmlParser.new(xml_doc)
      parsed.should_receive(:sort_speech_count).and_return([['Macbeth', 543], ['Banquo', 345], ['Duncan',220]])
      parsed.print_result
    end
  end
  
end