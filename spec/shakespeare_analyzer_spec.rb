require 'ostruct'
require 'shakespeare_analyzer'

describe ShakespeareAnalyzer do

  testfile = OpenStruct.new download_file: %Q|
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

  it "can use a downloader to retrieve a file" do
    double_downloader = double("double downloader")
    expect(double_downloader).to receive(:download_file)
    test_analyzer = ShakespeareAnalyzer.new downloader: double_downloader
  end
    
  it "prints the results" do
    test_analyzer = ShakespeareAnalyzer.new downloader: testfile
    expect(STDOUT).to receive(:puts).with("Benjamin Sisko: 3 lines")
    test_analyzer.print_lines
  end
end
