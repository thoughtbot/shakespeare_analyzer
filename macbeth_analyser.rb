require 'nokogiri'

class MacbethAnalyser
  attr_reader :xml

  def initialize(xml)
    @xml = xml
  end

  def run
    doc = Nokogiri::XML(xml)
    speech_nodes = doc.css('SPEECH')
    result = Hash.new(0)
    speech_nodes.map do |speech_node|
      speaker = speech_node.at('SPEAKER').text
      result[speaker] += speech_node.css('LINE').size
      result[speaker]
    end
    Hash[result.sort_by {|_key, value| value }.reverse]
  end
end
