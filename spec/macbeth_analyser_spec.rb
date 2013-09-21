require_relative '../macbeth_analyser'

describe MacbethAnalyser do
  describe "#run" do
    let(:analyser) { MacbethAnalyser.new(@xml) }

    it "returns an empty hash for an empty document" do
      @xml = ""
      #analyser = MacbethAnalyser.new("")
      expect(analyser.run).to eq({})
    end

    it "counts the lines in a play containing one speaker and one line" do
      @xml = """
        <PLAY>
          <SPEECH>
            <SPEAKER>Third Witch</SPEAKER>
            <LINE>That will be ere the set of sun.</LINE>
          </SPEECH>
        </PLAY>
      """
      expect(analyser.run).to eq({'Third Witch' => 1})
    end

    it "counts the lines in a play containing one speaker and multiple lines" do
      @xml = """
        <PLAY>
          <SPEECH>
            <SPEAKER>DUNCAN</SPEAKER>
            <LINE>What bloody man is that? He can report,</LINE>
            <LINE>As seemeth by his plight, of the revolt</LINE>
            <LINE>The newest state.</LINE>
          </SPEECH>
        </PLAY>
      """
      expect(analyser.run).to eq({'DUNCAN' => 3})
    end

    it "counts the lines in a play containing multiple speakers and multiple lines" do
      @xml = """
        <PLAY>
          <SPEECH>
            <SPEAKER>Second Witch</SPEAKER>
            <LINE>When the hurlyburly's done,</LINE>
            <LINE>When the battle's lost and won.</LINE>
          </SPEECH>
          <SPEECH>
            <SPEAKER>Third Witch</SPEAKER>
            <LINE>That will be ere the set of sun.</LINE>
          </SPEECH>
        </PLAY>
      """
      expect(analyser.run).to eq({'Second Witch' => 2, 'Third Witch' => 1})
    end
  end
end
