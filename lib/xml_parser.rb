require 'nokogiri'

class XmlParser
  def initialize(xml)
    @doc = Nokogiri.XML(xml)
  end

  def count_lines_by_speaker(speaker)
    @doc.css("PLAY SPEECH:has(SPEAKER[text()='#{speaker}']) LINE").count
  end

  def speakers
    @doc.css('PLAY SPEAKER').map { |speaker| speaker.text }.uniq
  end
end
