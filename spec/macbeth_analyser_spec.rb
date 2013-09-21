require_relative '../macbeth_analyser'

describe MacbethAnalyser do
  describe "#run" do
    it "returns an empty hash for an empty document" do
      analyser = MacbethAnalyser.new("")
      expect(analyser.run).to eq({})
    end
  end
end
