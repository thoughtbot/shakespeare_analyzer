require 'ostruct'
require 'shakespeare_analyzer'

describe ShakespeareAnalyzer do

  testfile = OpenStruct.new get_xml: %Q|
  <PLAY>
    <ACT>
      <SCENE>
        <SPEECH>
          <SPEAKER>Benjamin Sisko</SPEAKER>
          <LINE>Don't you understand? They're REAL!</LINE>
          <LINE>I CREATED THEM!</LINE>
          <LINE>You cannot destroy an IDEA!</LINE>
        </SPEECH>
      </SCENE>
    </ACT>
  </PLAY>|

  it "can use a xml retriever object to retrieve a file" do
    double_xmler = double("double xmler")
    expect(double_xmler).to receive(:get_xml)
    test_analyzer = ShakespeareAnalyzer.new xml_provider: double_xmler
  end
    
  it "prints the results" do
    test_analyzer = ShakespeareAnalyzer.new xml_provider: testfile
    expect(STDOUT).to receive(:puts).with("Benjamin Sisko: 3 lines")
    test_analyzer.print_lines
  end
end
