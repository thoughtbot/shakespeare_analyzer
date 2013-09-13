require "spec_helper"

describe XmlParser do

  before :all do
    @xml_parser_with_file = XmlParser.new("macbeth.xml")
    @xml_parser_with_url = XmlParser.new(XML_URL)
  end

  describe "#create_rexml_document" do

    it "should create a new REXML document when sent a file" do
      expect(@xml_parser_with_file.create_rexml_document.class).to eql REXML::Document 
    end

    it "should create a new REXML document when sent a url" do
      expect(@xml_parser_with_url.create_rexml_document.class).to eql REXML::Document 
    end

  end

end
