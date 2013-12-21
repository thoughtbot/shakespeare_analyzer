require_relative '../lib/string_content'
describe StringContent do
  before do
    macbeth_xml = %Q(
    
    <SPEECH>
    <SPEAKER>First Witch</SPEAKER>
    <LINE>When shall we three meet again</LINE>
    <LINE>In thunder, lightning, or in rain?</LINE>
    <LINE>And I prevail finally</LINE>
    </SPEECH>
   
    )
    @content = StringContent.new(macbeth_xml)
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