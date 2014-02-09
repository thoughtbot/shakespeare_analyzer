require 'nokogiri'

class ShakespeareAnalyzer
  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def run
    doc = Nokogiri::XML(xml)
    @speeches = doc.css('SPEECH')
    speakers = get_speakers_from_speeches
  end

  def get_speakers_from_speeches
    results = Hash.new(0)
    @speeches.map do |speech|
      speaker = speech.css('SPEAKER').text
      results[speaker] += speech.css('LINE').length
    end
    results
  end
end