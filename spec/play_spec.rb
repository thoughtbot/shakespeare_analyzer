require 'play'

describe Play do
  let(:play) { Play.new @xml }

  describe "#characters_and_their_number_of_lines" do
    context "the play is empty" do
      it "returns an empty hash" do
        @xml = ""
        play.characters_and_their_number_of_lines.should == {}
      end
    end

    context "play contains one line" do
      it "counts the one line" do
        @xml = """
          <PLAY>
            <SPEECH>
              <SPEAKER>Macbeth</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
          </PLAY>
        """
        play.characters_and_their_number_of_lines.should == {"Macbeth" => 1}
      end
    end

    context "play contains one speaker and multiple lines" do
      it "counts the lines of the speaker" do
        @xml = """
          <PLAY>
            <SPEECH>
              <SPEAKER>Macbeth</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>Macbeth</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
          </PLAY>
        """
        play.characters_and_their_number_of_lines.should == {"Macbeth" => 4}
      end
    end

    context "play contains multiple speakers with multiple lines" do
      it "counts the lines of each speaker" do
        @xml = """
          <PLAY>
            <SPEECH>
              <SPEAKER>Macbeth</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>Bruce Lee</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>Paul Phoenix</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
              <LINE>That will be ere the set of sun.</LINE>
              <LINE>That will be ere the set of sun.</LINE>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
          </PLAY>
        """
        play.characters_and_their_number_of_lines.should == {
          "Macbeth" => 2,
          "Bruce Lee" => 1,
          "Paul Phoenix" => 4,
        }
      end
    end

    it "converts the names it finds to titlecase" do
        @xml = """
          <PLAY>
            <SPEECH>
              <SPEAKER>MACBETH</SPEAKER>
              <LINE>That will be ere the set of sun.</LINE>
            </SPEECH>
          </PLAY>
        """
        play.characters_and_their_number_of_lines.should == {
          "Macbeth" => 1,
        }
    end
  end
end
