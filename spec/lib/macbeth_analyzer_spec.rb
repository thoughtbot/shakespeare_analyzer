require 'spec_helper'

describe MacbethAnalyzer do
  describe "#line_counts" do
    context "with a single speaker" do
      before do
        speech = %{
          <SPEECH>
            <SPEAKER>First Witch</SPEAKER>
            <LINE>When shall we three meet again</LINE>
            <LINE>In thunder, lightning, or in rain?</LINE>
          </SPEECH>
        }
        @analyzer = described_class.new(speech)
      end

      it "returns line count" do
        expected = { "First Witch" => 2 }
        expect(@analyzer.line_counts).to eq(expected)
      end
    end

    context "with two different speakers" do
      before do
        two_speeches = %{
          <SCENE>
            <SPEECH>
              <SPEAKER>First Witch</SPEAKER>
              <LINE>When shall we three meet again</LINE>
              <LINE>In thunder, lightning, or in rain?</LINE>
            </SPEECH>

            <SPEECH>
              <SPEAKER>Second Witch</SPEAKER>
              <LINE>When the hurlyburly's done,</LINE>
              <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
          </SCENE>
        }
        @two_speech_analyzer = described_class.new(two_speeches)
      end

      it "it returns line count" do
        expected = { "First Witch" => 2, "Second Witch" => 2 }
        expect(@two_speech_analyzer.line_counts).to eq(expected)
      end
    end

    context "with the same speaker twice" do
      before do
        same_speaker_twice = %{
          <SCENE>
            <SPEECH>
              <SPEAKER>First Witch</SPEAKER>
              <LINE>When shall we three meet again</LINE>
              <LINE>In thunder, lightning, or in rain?</LINE>
            </SPEECH>

            <SPEECH>
              <SPEAKER>First Witch</SPEAKER>
              <LINE>When the hurlyburly's done,</LINE>
              <LINE>When the battle's lost and won.</LINE>
            </SPEECH>
          </SCENE>
        }
        @same_speaker_analyzer = described_class.new(same_speaker_twice)
      end

      it "returns line count" do
        expected = { "First Witch" => 4 }
        expect(@same_speaker_analyzer.line_counts).to eq expected
      end
    end

    context "with two speakers saying the same line" do
      before do
        speech = %{
          <SCENE>
            <SPEECH>
              <SPEAKER>First Witch</SPEAKER>
              <SPEAKER>Second Witch</SPEAKER>
              <LINE>When shall we three meet again</LINE>
              <LINE>In thunder, lightning, or in rain?</LINE>
            </SPEECH>
          </SCENE
        }
        @analyzer = described_class.new(speech)
      end

      it "increments both speakers' line counts" do
        expected = { "First Witch" => 2, "Second Witch" => 2 }
        expect(@analyzer.line_counts).to eq expected
      end
    end
  end

  describe "#formatted_line_counts" do
    before do
      two_speeches = %{
        <SCENE>
          <SPEECH>
            <SPEAKER>First Witch</SPEAKER>
            <LINE>When shall we three meet again</LINE>
          </SPEECH>

          <SPEECH>
            <SPEAKER>Second Witch</SPEAKER>
            <LINE>When the hurlyburly's done,</LINE>
            <LINE>When the battle's lost and won.</LINE>
          </SPEECH>
        </SCENE>
      }
      @two_speech_analyzer = described_class.new(two_speeches)
    end

    it "produces formatted output" do
      expected = "2 Second Witch\n1 First Witch"
      expect(@two_speech_analyzer.formatted_line_counts).to eq expected
    end
  end
end
