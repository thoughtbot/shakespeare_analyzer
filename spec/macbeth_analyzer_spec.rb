require 'spec_helper'

describe MacbethAnalyzer do

  before :each do
    @macbeth_analyzer = MacbethAnalyzer.new
  end

  describe "#new" do
    it "should be an instance of the MacbethAnalyzer class" do
      @macbeth_analyzer.should be_an_instance_of MacbethAnalyzer
    end
  end

  # What tests do I need to write?
  # List the things I want to accomplish...
  # 1. Load some gems.
  # 2. Get the XML from the remote site and save it to a variable.
  # 3. Parse that XML and find the "SPEECH" elements
  # 4. Loop through and get the speaker name and count their lines. 
  # 5. Store that in a hash.
  # 6. Sort the hash.
  # 7. Write to STDOUT.

  # This is where I am most in need of help. I understand that I should write 
  # tests but I am always lost when it comes time to do it.

end
