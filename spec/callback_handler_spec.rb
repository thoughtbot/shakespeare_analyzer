require 'callback_handler'

describe CallbackHandler do
  before (:each) do
    @handler = CallbackHandler.new
    @parser = XML::SAX::Parser.new(@handler)
  end

  it "correctly parses an empty file" do
    @parser.parse_file("spec/empty_file.xml")
    @handler.results.keys.should be_empty
  end

  it "correctly parses a file with only one speaker" do
    @parser.parse_file("spec/one_speaker.xml")
    @handler.results.keys.should_not be_empty
    @handler.results["MACBETH"].should eq(1)
  end

  it "correctly parses a file with multiple speakers" do
    @parser.parse_file("spec/multiple_speakers.xml")
    @handler.results.keys.should_not be_empty

    @handler.results["LENNOX"].should eq(1)
    @handler.results["MACBETH"].should eq(2)
    @handler.results["MACDUFF"].should eq(6)
  end

  it "correctly parses a file with a speaker of all" do
    @parser.parse_file("spec/all_speaker.xml")
    @handler.results.keys.should_not be_empty

    @handler.results["First Witch"].should eq(6)
    @handler.results["Second Witch"].should eq(6)
    @handler.results["Third Witch"].should eq(5)
    @handler.results["ALL"].should eq(0)
  end
end
