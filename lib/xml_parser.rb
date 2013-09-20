require 'nokogiri'

class XmlParser
  def initialize(xml)
    @doc = Nokogiri.XML(xml)
  end

  def speakers_sorted_by_line_count
    speakers_with_line_count.sort_by { |_key, value| value }.reverse
  end

  private

  def speakers_with_line_count
    Hash[*speakers.map { |speaker| [speaker, count_lines_by_speaker(speaker)] }.flatten]
  end

  def speakers
    @doc.css('PLAY SPEAKER').map { |speaker| speaker.text }.uniq
  end

  def count_lines_by_speaker(speaker)
    @doc.css("PLAY SPEECH:has(SPEAKER[text()='#{speaker}']) LINE").count
  end
end
