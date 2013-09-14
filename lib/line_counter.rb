class LineCounter
  def initialize
    @speaker = []
    @count = Hash.new(0)
  end

  def count
    @count
  end

  def add_speaker(name)
    @speaker.push name
  end

  def count_line
    @speaker.each do |name|
      @count[name] += 1
    end

    raise ArgumentError, 'Unable to count lines without a speaker.'  if @speaker.empty?
  end

  def new_speech
    @speaker = []
  end
end
