require 'line_counter'

describe LineCounter, "#count" do
  before (:each) do
    @counter = LineCounter.new
  end

  it "returns an empty list when no lines are counted" do
    @counter.count.should be_empty
  end

  it "increments the current speaker when a speaker is added" do
    @counter.add_speaker "Macbeth"

    @counter.count_line
    @counter.count["Macbeth"].should eq(1)

    @counter.count_line
    @counter.count["Macbeth"].should eq(2)
  end

  it "throws exception when a line is counted without a speaker" do
    expect {@counter.count_line}.to raise_error(ArgumentError)
  end

  it "allows two people to speak at the same time" do
    @counter.add_speaker "Macbeth"
    @counter.add_speaker "Banquo"

    @counter.count_line
    @counter.count["Macbeth"].should eq(1)
    @counter.count["Banquo"].should eq(1)

    @counter.count_line
    @counter.count["Macbeth"].should eq(2)
    @counter.count["Banquo"].should eq(2)
  end

  it "does not count lines from speakers of previous speeches" do
    @counter.add_speaker "Macbeth"

    @counter.new_speech
    
    @counter.add_speaker "Duncan"
    @counter.count_line

    @counter.count["Duncan"].should eq(1)
    @counter.count.key?("Macbeth").should be_false
  end

  it "increments all speakers in the scene when the speaker is all" do
    @counter.add_speaker "Macbeth"
    @counter.count_line

    @counter.new_speech
    @counter.add_speaker "Banquo"
    @counter.count_line
    @counter.count_line

    @counter.new_speech
    @counter.add_speaker "ALL"
    @counter.count_line

    @counter.count["Macbeth"].should eq(2)
    @counter.count["Banquo"].should eq(3)
    @counter.count["ALL"].should eq(0)
  end

  it "increments only the speakers in the scene when the speaker is all" do
    @counter.add_speaker "Macbeth"
    @counter.count_line

    @counter.new_scene
    @counter.new_speech
    @counter.add_speaker "Banquo"
    @counter.count_line

    @counter.new_speech
    @counter.add_speaker "Duncan"
    @counter.count_line
    @counter.count_line

    @counter.new_speech
    @counter.add_speaker "ALL"
    @counter.count_line

    @counter.count["Macbeth"].should eq(1)
    @counter.count["Banquo"].should eq(2)
    @counter.count["Duncan"].should eq(3)
    @counter.count["ALL"].should eq(0)
  end
end
