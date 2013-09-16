require 'set'

class LineCounter
  def initialize
    @speaker = []
    @scene_speakers = Set.new
    @count = Hash.new(0)
  end

  def count
    @count
  end

  def add_speaker(name)
    @speaker.push name
    @scene_speakers.add name unless name == 'ALL'
  end

  def count_line
    names = (@speaker.include?("ALL")) ? @scene_speakers : @speaker
    increment_names(names)
    raise ArgumentError, 'Unable to count lines without a speaker.'  if @speaker.empty?
  end

  def increment_names(names)
    names.each do |name|
      @count[name] += 1
    end
  end

  def new_speech
    @speaker = []
  end

  def new_scene
    @scene_speakers = Set.new
  end
end
