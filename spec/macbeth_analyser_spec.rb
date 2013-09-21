require_relative '../macbeth_analyser'

describe MacbethAnalyser do
  describe "#run" do
    let(:analyser) { MacbethAnalyser.new(@xml) }

    it "returns an empty hash for an empty document" do
      @xml = ""
      #analyser = MacbethAnalyser.new("")
      expect(analyser.run).to eq({})
    end

    it "counts the lines in a fragment containing one speaker and one line" do
      @xml = """
        <SPEECH>
          <SPEAKER>Third Witch</SPEAKER>
          <LINE>That will be ere the set of sun.</LINE>
        </SPEECH>
      """
      expect(analyser.run).to eq({'Third Witch' => 1})
    end

    it "counts the lines in a fragment containing one speaker and multiple lines" do
      @xml = """
        <SPEECH>
          <SPEAKER>DUNCAN</SPEAKER>
          <LINE>What bloody man is that? He can report,</LINE>
          <LINE>As seemeth by his plight, of the revolt</LINE>
          <LINE>The newest state.</LINE>
        </SPEECH>
      """
      expect(analyser.run).to eq({'DUNCAN' => 3})
    end
  end
end
