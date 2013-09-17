require 'spec_helper'

describe MacbethAnalyzer do
  let(:analyzer) { MacbethAnalyzer.new }

  def stub_contents_with(file_name)
    allow(analyzer).to receive(:contents).and_return(File.open(fixture_path(file_name)).read)  
  end  

  describe "attributes" do
    it "has url attribute" do
      expect(analyzer.url).to eq "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    end

    it "allows user to dump the entire content into a string", :external do
      expect(MacbethAnalyzer.new.contents.split(/\n/).count).to be > 100
    end
  end
  

  # these will very quickly test whether the methods are working at all
  context "given we are able to read a small xml file with similar features as the official file" do

    before do 
      stub_contents_with("small.xml")  
    end

    it "has many lines" do
      expect(analyzer.contents.split(/\n/).count).to eq 19
    end

    describe "#speeches" do
      it "picks out all the speeches" do
        expect(analyzer.speeches.count).to eq 2
      end
      it "contains an array of speaches that each has a speaker and an array of lines" do
        speeches = analyzer.speeches
        expect(speeches[0][:speaker]).to eq "First Witch"
        expect(speeches[0][:line_count]).to eq 1
        expect(speeches[1][:speaker]).to eq "Second Witch"
        expect(speeches[1][:line_count]).to eq 2
      end
    end

    describe "#analyze" do
      it 'returns speakers with the number of lines spoken' do
        expect(analyzer.analyze).to eq({
          "First Witch" => 1,
          "Second Witch" => 2
        })
      end
    end

    describe "#output" do
      it 'returns an array of string sorted by lines spoken' do
        expect(analyzer.output).to eq([
          "  2 Second Witch",
          "  1 First Witch"
        ])
      end
    end
  end

  # the following tests should help us make sure results from the original
  # file is still sane
  context "given we are able to read the official xml file" do

    before do 
      stub_contents_with('macbeth.xml')
    end

    it 'returns First Witch to be 62' do
      result = analyzer.analyze
      expect(result["First Witch"]).to eq 62
    end
  end
end