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
      hash = { "Pi" => 314, "Life" => 42 }
      run = ShakespeareAnalyzer.new.run hash
      expect(run).to eql "314\tPi\n42\tLife\n"
    end

  end


end
