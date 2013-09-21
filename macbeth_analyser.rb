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
      { speaker => 1 }
    else
      {}
    end
  end
end
