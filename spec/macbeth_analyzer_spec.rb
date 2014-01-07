require 'spec_helper'

describe MacbethAnalyzer do
  describe '#results' do
    it "returns hash of lines per speaker" do
      xml = <<-XML
      <?xml version="1.0"?>
      <!DOCTYPE PLAY SYSTEM "play.dtd">
      <PLAY>
      <ACT><TITLE>ACT I</TITLE>
      <SCENE><TITLE>SCENE I.  A desert place.</TITLE>

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

      <SPEECH>
      <SPEAKER>Third Witch</SPEAKER>
      <LINE>That will be ere the set of sun.</LINE>
      </SPEECH>

      <SPEECH>
      <SPEAKER>First Witch</SPEAKER>
      <LINE>Where the place?</LINE>
      </SPEECH>

      </SCENE>
      </ACT>
      </PLAY>
      XML
      subject.stub(:xml) { xml }
      expected_results = {
        "First Witch" => 3,
        "Second Witch" => 2,
        "Third Witch" => 1
      }
      subject.results.should eq(expected_results)
    end
  end

  describe '#to_s' do
    it "returns sorted print-friendly results" do
      subject.stub(:results) { {"John" => 123, "Mary" => 456} }
      subject.to_s.should eq("456 Mary\n123 John")
    end
  end

  describe '#xml' do
    it "reads xml from source" do
      url = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
      Kernel.stub(:open).with(url) { double(read: 'the xml') }
      subject.xml.should eq('the xml')
    end
  end
end
