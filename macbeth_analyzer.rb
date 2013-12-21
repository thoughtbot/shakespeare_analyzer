require 'nokogiri'
require_relative 'lib/ibiblio'

Nokogiri::XML(Ibiblio.find('Macbeth')).search('SPEECH').inject(Hash.new(0)) do |obj, speech|
  speaker = speech.search('SPEAKER').text.capitalize
  lines   = speech.search('LINE').count
  obj.tap { |o| o[speaker] += lines }
end.sort_by {|a, b| -b}.each { |speaker, count| puts "#{count.to_s.rjust(3)}  #{speaker}" }

# Ibiblio.find('Macbeth').speeches.inject(Hash.new(0)) do |obj, speech|
#   obj.tap { |o| o[speech.speaker] += speech.length }
# end

class Play
  def speeches

  end
end

class NullPlay < Play
  def speeches
    []
  end
end

class Speech < Struct.new(:speaker, :lines)
  def length
    lines.count
  end
end

# a play has a number of speeches
# a speech has a speaker and an array of lines

# play = Ibiblio.find('Macbeth')

# downloading / catalogue?
# xml parsing
# play/speech/lines
# counter/aggregator
