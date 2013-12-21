require_relative '../lib/http_content'
require 'spec_helper'
describe HttpContent do
  before do
    macbeth_url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    macbeth_xml = %Q(
    <SPEECH>
    <SPEAKER>First Witch</SPEAKER>
    <LINE>When shall we three meet again</LINE>
    <LINE>In thunder, lightning, or in rain?</LINE>
    <LINE>And I prevail finally</LINE>
    </SPEECH>
    )
    stub_request(:get, macbeth_url).to_return(body: macbeth_xml)
    @content = HttpContent.new(macbeth_url)
  end
  subject { @content }
  it {should respond_to(:source)}
  it {should respond_to(:data)}
  describe "#get_content_from_source" do
    it "should return a Nokigiri document" do
      expect(@content.data.class).to eq(Nokogiri::XML::Document)
    end
  end
  
  
end