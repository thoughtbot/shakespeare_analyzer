require 'nokogiri'
require_relative 'lib/ibiblio'

class MyMain
  def initialize(argv, stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel
  end

  def execute!
    $stdin = @stdin
    $stdout = @stdout

    Nokogiri::XML(Ibiblio.find('Macbeth')).search('SPEECH').inject(Hash.new(0)) do |obj, speech|
      speaker = speech.search('SPEAKER').text.capitalize
      lines   = speech.search('LINE').count
      obj.tap { |o| o[speaker] += lines }
    end.sort_by {|a, b| -b}.each { |speaker, count| puts "#{count.to_s.rjust(3)}  #{speaker}" }
  end
end

MyMain.new(ARGV.dup).execute!

# Ibiblio.find('Macbeth').speeches.inject(Hash.new(0)) do |obj, speech|
#   obj.tap { |o| o[speech.speaker] += speech.length }
# end

# PlayAnalyzer.new(Ibiblio.find('Macbeth')).lines_by_character.each do |lines_count, character|
#   puts "#{lines_count.to_s.rjust(3)} #{character}"
# end

# LinesCounter.new(Ibiblio.find('Macbeth')).sort(:desc).each do |count, character|
#   puts "#{count.to_s.rjust(3)} #{character}"
# end

class Play
  SPEECH = 'SPEECH'
  SPEAKER = 'SPEAKER'
  LINE = 'LINE'

  def initialize(play)
    @play = play
  end

  def speeches
    @speeches ||= @play.search(SPEECH).map do |speech|
      Speech.new(speaker, lines)
    end
  end

  private

  def parse_speeches(xml)
    xml.search(SPEECH)
  end

  def parse_speaker(xml)
    xml.search(SPEAKER)
  end

  def parse_lines(xml)
    xml.seach(LINE)
  end
end

class EmptyPlay
  def speeches
    []
  end
end

class Speech < Struct.new(:speaker, :lines)
  def length
    lines.count
  end
end

# a catalogue returns a play
# a play has a number of speeches
# a speech has a speaker and a collection of lines

# play = Ibiblio.find('Macbeth')

# downloading / catalogue?
# xml parsing
# play/speech/lines
# counter/aggregator
