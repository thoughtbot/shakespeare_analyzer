require 'nokogiri'

class MacbethAnalyser
  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def run
    doc = Nokogiri::XML(xml)
    speaker_node = doc.at('SPEAKER')
    if speaker_node
      speaker = speaker_node.text
      lines = speaker_node.xpath('../LINE').size
      { speaker => lines }
    else
      {}
    end
  end
end
