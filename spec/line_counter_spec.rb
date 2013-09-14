require 'line_counter'

describe LineCounter, "#count" do
  it "returns an empty list when no lines are counted" do
    counter = LineCounter.new
    counter.count.should be_empty
  end

  it "increments the current speaker when a speaker is added" do
    counter = LineCounter.new
    counter.add_speaker "Macbeth"

    counter.count_line
    counter.count["Macbeth"].should eq(1)

    counter.count_line
    counter.count["Macbeth"].should eq(2)
  end

  it "throws exception when a line is counted without a speaker" do
    counter = LineCounter.new
    expect {counter.count_line}.to raise_error(ArgumentError)
  end

  it "allows two people to speak at the same time" do
    counter = LineCounter.new
    counter.add_speaker "Macbeth"
    counter.add_speaker "Banquo"

    counter.count_line
    counter.count["Macbeth"].should eq(1)
    counter.count["Banquo"].should eq(1)

    counter.count_line
    counter.count["Macbeth"].should eq(2)
    counter.count["Banquo"].should eq(2)
  end

  it "does not count lines from speakers of previous speeches" do
    counter = LineCounter.new
    counter.add_speaker "Macbeth"

    counter.new_speech
    
    counter.add_speaker "Duncan"
    counter.count_line

    counter.count["Duncan"].should eq(1)
    counter.count.key?("Macbeth").should be_false
  end
end
