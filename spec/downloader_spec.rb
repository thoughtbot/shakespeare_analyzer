require 'downloader'


describe Downloader do
  
  it "returns data from a file or url" do
    downloader = Downloader.new(file: "./spec/test.xml")
    test_file = downloader.get_xml
    expect(test_file).to include "Macbeth"
  end

end
