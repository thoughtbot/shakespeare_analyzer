require_relative '../lib/shakespeare_analyzer'
require 'content'
require 'file_content'
require 'string_content'
require 'http_content'
#require 'spec_helper'
describe "ShakespeareAnalyzer" do
  
  before do
    @macbeth_url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    @macbeth_xml = %Q(
    <PLAY>
    <ACT>
    <SCENE>
    <SPEECH>
    <SPEAKER>First Witch</SPEAKER>
    <LINE>When shall we three meet again</LINE>
    <LINE>In thunder, lightning, or in rain?</LINE>
    <LINE>And I prevail finally</LINE>
    </SPEECH>
    <SPEECH>
        <SPEAKER>Second Witch</SPEAKER>
        <LINE>When the hurlyburly's done,</LINE>
        <LINE>When the battle's lost and won.</LINE>
        </SPEECH>
        <SPEECH>
        <SPEAKER>Third Witch</SPEAKER>
        <LINE>That will be ere the set of sun.</LINE>
        </SPEECH>
        </SCENE>
        <SCENE>
        <SPEECH>
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
        <LINE>And I prevail finally</LINE>
        </SPEECH>
        <SPEECH>
            <SPEAKER>Second Witch</SPEAKER>
            <LINE>When the hurlyburly's done,</LINE>
            <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
            <SPEECH>
            <SPEAKER>Third Witch</SPEAKER>
            <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            </SCENE>
        </ACT>
        <ACT>
        <SCENE>
        <SPEECH>
        <SPEAKER>First Witch</SPEAKER>
        <LINE>When shall we three meet again</LINE>
        <LINE>In thunder, lightning, or in rain?</LINE>
        <LINE>And I prevail finally</LINE>
        </SPEECH>
        <SPEECH>
            <SPEAKER>Second Witch</SPEAKER>
            <LINE>When the hurlyburly's done,</LINE>
            <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
            <SPEECH>
            <SPEAKER>Third Witch</SPEAKER>
            <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            </SCENE>
            <SCENE>
            <SPEECH>
            <SPEAKER>First Witch</SPEAKER>
            <LINE>When shall we three meet again</LINE>
            <LINE>In thunder, lightning, or in rain?</LINE>
            <LINE>And I prevail finally</LINE>
            </SPEECH>
            <SPEECH>
                <SPEAKER>Second Witch</SPEAKER>
                <LINE>When the hurlyburly's done,</LINE>
                <LINE>When the battle's lost and won.</LINE>
                </SPEECH>
                <SPEECH>
                <SPEAKER>Fourth Witch</SPEAKER>
                <LINE>That will be ere the set of sun.</LINE>
                </SPEECH>
                </SCENE>
            </ACT>
        </PLAY>
    )
  end
  
  it "should respond to #analyze" do
    content = StringContent.new(@macbeth_url)
    analyzer = ShakespeareAnalyzer.new(content.data)
    expect(analyzer).to respond_to(:analyze)
  end
  
  it "should respond to #print_result" do
    content = StringContent.new(@macbeth_url)
    analyzer = ShakespeareAnalyzer.new(content.data)
    expect(analyzer).to respond_to(:print_result)
  end
  
  describe "#initialize" do
    it "takes in the content and stores the downloaded data in @data" do
      content = StringContent.new(@macbeth_url)
      analyzer = ShakespeareAnalyzer.new(content.data)
      expect(analyzer.doc.class).to eq(Nokogiri::XML::Document)
    end
  end
 
 
  it "can analyze an xml string" do
   
    content = StringContent.new(@macbeth_xml)
    analyzer = ShakespeareAnalyzer.new(content.data)
    analyzer.analyze
    result = analyzer.result
    expect(result).to eq({"First Witch"=>12, "Second Witch"=>8, "Third Witch"=>3,"Fourth Witch" => 1})
  end
 
  it "can analyze an xml file" do
    content = FileContent.new("macbeth.xml")
    analyzer = ShakespeareAnalyzer.new(content.data)
    analyzer.analyze
    result = analyzer.result
    expect(result).to eq({"First Witch"=>62, "Second Witch"=>27, "Third Witch"=>27, "ALL"=>24, "DUNCAN"=>70, "MALCOLM"=>212, "Sergeant"=>35, "LENNOX"=>73, "ROSS"=>135, "MACBETH"=>718, "BANQUO"=>113, "ANGUS"=>21, "LADY MACBETH"=>265, "Messenger"=>23, "FLEANCE"=>2, "Porter"=>46, "MACDUFF"=>180, "MACBETHLENNOX"=>1, "DONALBAIN"=>10, "Old Man"=>11, "ATTENDANT"=>1, "First Murderer"=>30, "Second Murderer"=>15, "Both Murderers"=>2, "Servant"=>5, "Third Murderer"=>8, "Lords"=>3, "HECATE"=>39, "Lord"=>21, "First Apparition"=>2, "Second Apparition"=>4, "Third Apparition"=>5, "LADY MACDUFF"=>41, "Son"=>20, "Doctor"=>45, "Gentlewoman"=>23, "MENTEITH"=>12, "CAITHNESS"=>11, "SEYTON"=>5, "SIWARD"=>30, "Soldiers"=>1, "YOUNG SIWARD"=>7})
  end
 
  it "can analyze xml file from internet" do
    stub_request(:get, "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml").
          to_return(:status => 200, :body => @macbeth_xml, :headers => {})
    content = HttpContent.new(@macbeth_url)
    analyzer = ShakespeareAnalyzer.new(content.data)
    analyzer.analyze
    result = analyzer.result
    expect(result).to eq({"First Witch"=>12, "Second Witch"=>8, "Third Witch"=>3,"Fourth Witch" => 1})
  end
end



  
 
