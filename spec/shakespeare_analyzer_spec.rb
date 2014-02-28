require_relative '../lib/shakespeare_analyzer'
require 'rspec'

describe ShakespeareAnalyzer do
  
  it { ShakespeareAnalyzer::REMOTE_XML_URL.should_not be_nil }

  describe ".new" do
    it "should instantiate with XmlParser instance" do
      parser = double(XmlParser)
      XmlParser.should_receive(:new).with(ShakespeareAnalyzer::REMOTE_XML_URL).and_return(parser)
      sa = ShakespeareAnalyzer.new
      sa.xml_doc.should == parser
    end
  end
  
  describe "#print_result" do
    before do
      @parser = double(XmlParser)
      XmlParser.stub(:new).and_return(@parser)
      @parser.stub(:speech_count).and_return({'Macbeth' => 543, 'Banquo' => 345, 'Duncan' => 220})
    end
    
    it "should print results" do
      STDOUT.should_receive(:puts).with("543 Macbeth")
      STDOUT.should_receive(:puts).with("345 Banquo")
      STDOUT.should_receive(:puts).with("220 Duncan")
      sa = ShakespeareAnalyzer.new
      sa.print_speech_counts
    end
  end

end