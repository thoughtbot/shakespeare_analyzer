require_relative '../macbeth_analyser'

describe MacbethAnalyser do
  describe "#run" do
    it "returns an empty hash for an empty document" do
      analyser = MacbethAnalyser.new("")
      expect(analyser.run).to eq({})
    end

    it "counts the lines in a fragment containing one speaker and one line" do
      xml = """
        <SPEECH>
          <SPEAKER>Third Witch</SPEAKER>
          <LINE>That will be ere the set of sun.</LINE>
        </SPEECH>
      """
      analyser = MacbethAnalyser.new(xml)
      expect(analyser.run).to eq({'Third Witch' => 1})
    end
  end
end
