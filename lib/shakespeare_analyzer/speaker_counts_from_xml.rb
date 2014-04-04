require_relative 'speaker'

module SpeakerCountsFromXml
  extend self

  def call(xml)
    speaker_line_counts_from(xml)
  end

protected

  def xml_doc(xml)
    Nokogiri::XML(xml)
  end

  def speaker_line_counts_from(xml)
    xml_doc(xml).search('SPEECH').map do |speech|
      speaker = speech.at('SPEAKER').text
      lines   = speech.search('LINE').map(&:text)
      Speaker.new(speaker, lines.count)
    end
  end
end
