require 'nokogiri'

class XmlParser
  def initialize(xml)
    @doc = Nokogiri.XML(xml)
  end

  def lines_by_speaker(speaker)
    @doc.css("PLAY SPEAKER:contains('#{speaker}') ~ LINE").count
  end
end
