require 'nokogiri'

class ShakespeareAnalyzer
  attr_reader :xml, :results

  def initialize(xml)
    @xml = xml
    @results = Hash.new(0)
  end

  def run
    doc = Nokogiri::XML(xml)
    @speeches = doc.css('SPEECH')
    get_speakers_from_speeches
    results
  end

  def get_speakers_from_speeches
    @speeches.map do |speech|
      speaking = speech.css('SPEAKER')
      line_count = speech.css('LINE').length
      update_line_counts(speaking, line_count)
    end
  end

  def update_line_counts(speaking, line_count)
    speaking.each do |speaker|
      speaker = speaker.text
      results[speaker] += line_count
    end
  end
end