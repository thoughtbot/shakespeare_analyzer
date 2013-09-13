require "spec_helper"

describe ShakespeareAnalyzer do

  before :all do
    @shakespeare = ShakespeareAnalyzer.new
    @xml_url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  end

  describe "#new" do

    it "should be an instance of ShakespeareAnalyzer." do
      expect(@shakespeare).to  be_an_instance_of ShakespeareAnalyzer
    end

    it "should have a default value for the url variable." do
      expect(@shakespeare.url).to eql @xml_url
    end

    it "should allow the url value to be set upon initilization." do
      hamlet = ShakespeareAnalyzer.new "hamlet.xml"
      expect(hamlet.url).to eql "hamlet.xml"
    end

  end
  
  describe "#run" do

    it "should print out the name and line count for each character." do
      output = "718\tMACBETH\n265\tLADY MACBETH\n212\tMALCOLM\n180\tMACDUFF\n135\tROSS\n113\tBANQUO\n74\tLENNOX\n70\tDUNCAN\n62\tFirst Witch\n46\tPorter\n45\tDoctor\n41\tLADY MACDUFF\n39\tHECATE\n35\tSergeant\n30\tFirst Murderer\n30\tSIWARD\n27\tThird Witch\n27\tSecond Witch\n24\tALL\n23\tGentlewoman\n23\tMessenger\n21\tLord\n21\tANGUS\n20\tSon\n15\tSecond Murderer\n12\tMENTEITH\n11\tOld Man\n11\tCAITHNESS\n10\tDONALBAIN\n8\tThird Murderer\n7\tYOUNG SIWARD\n5\tThird Apparition\n5\tSEYTON\n5\tServant\n4\tSecond Apparition\n3\tLords\n2\tFirst Apparition\n2\tFLEANCE\n2\tBoth Murderers\n1\tATTENDANT\n1\tSoldiers\n"
      expect(@shakespeare.start).to eql output
    end

  end


end
