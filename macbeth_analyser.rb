require 'nokogiri'

class MacbethAnalyser
  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def run
    doc = Nokogiri::XML(xml)
    speech_nodes = doc.css('SPEECH')
    result = {}
    speech_nodes.map do |speech_node|
      speaker = speech_node.at('SPEAKER').text
      result[speaker] = speech_node.css('LINE').size
      result[speaker]
    end
    result
  end
end