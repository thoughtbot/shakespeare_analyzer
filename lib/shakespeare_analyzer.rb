require 'xml_parser'

class ShakespeareAnalyzer
  
  attr_reader :xml_doc
  REMOTE_XML_URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  
  def initialize
    @xml_doc = XmlParser.new(REMOTE_XML_URL)
  end
  
  def parse_speeches
    @xml_doc.parse_speeches
  end
  
  def print_speech_counts
    @xml_doc.speech_count.each do |name, count|
      puts "#{count} #{name}"
    end
  end
  
end