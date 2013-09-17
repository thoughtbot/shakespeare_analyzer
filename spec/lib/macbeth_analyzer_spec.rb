require 'spec_helper'

describe MacbethAnalyzer do

  describe "attributes" do
    subject { MacbethAnalyzer.new }

    it "has url attribute" do
      expect(subject.url).to eq "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    end
  end
	
  it "allows user to dump the entire content into a string", :external do
    expect(MacbethAnalyzer.new.contents.split(/\n/).count).to be > 100
  end

  context "given we are able to read the xml file" do
    let(:analyzer) { MacbethAnalyzer.new }

    before do 
      allow(analyzer).to receive(:contents).and_return(File.open(fixture_path('small.xml')).read)
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
        expect(speeches[0][:lines].count).to eq 1
        expect(speeches[1][:speaker]).to eq "Second Witch"
        expect(speeches[1][:lines].count).to eq 2
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

  context "given we are able to read the xml file" do
    let(:analyzer) { MacbethAnalyzer.new }

    before do 
      allow(analyzer).to receive(:contents).and_return(File.open(fixture_path('macbeth.xml')).read)
    end

    it 'returns First Witch to be 3' do
      result = analyzer.analyze
      expect(result["First Witch"]).to eq 62
    end
  end
end