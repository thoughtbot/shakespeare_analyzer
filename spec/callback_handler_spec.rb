require 'callback_handler'

describe CallbackHandler do
  it "correctly parses an empty file" do
    handler = CallbackHandler.new
    parser = XML::SAX::Parser.new(handler)
    parser.parse_file("spec/empty_file.xml")
    handler.results.keys.should be_empty
  end

  it "correctly parses a file with only one speaker" do
    handler = CallbackHandler.new
    parser = XML::SAX::Parser.new(handler)
    parser.parse_file("spec/one_speaker.xml")
    handler.results.keys.should_not be_empty
    handler.results["MACBETH"].should eq(1)
  end

  it "correctly parses a file with multiple speakers" do
    handler = CallbackHandler.new
    parser = XML::SAX::Parser.new(handler)
    parser.parse_file("spec/multiple_speakers.xml")
    handler.results.keys.should_not be_empty

    handler.results["LENNOX"].should eq(1)
    handler.results["MACBETH"].should eq(2)
    handler.results["MACDUFF"].should eq(6)
  end

end
