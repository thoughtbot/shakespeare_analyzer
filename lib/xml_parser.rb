require 'nokogiri'
require 'open-uri'

class XmlParser 
  
  attr_reader :doc, :speech_count
  
  def initialize(url_or_path)
    @doc = Nokogiri::XML(open(url_or_path))
    @speech_count = {}
  end
  
  def count_lines(element)
    element.xpath(".//LINE").count
  end
  
  def get_speakers(element)
    element.xpath(".//SPEAKER").map(&:text)
  end
  
  def parse_speeches
    @doc.xpath("//SPEECH").each do |speech|
      get_speakers(speech).each do |speaker|
        @speech_count[speaker] ||= 0
        @speech_count[speaker] += count_lines(speech)
      end
    end
  end
  
  def sort_speech_count
    (@speech_count.sort_by {|k,v| v}).reverse
  end
  
  def print_result
    sort_speech_count.each do |result|
      puts "#{result[1]} #{result[0]}"
    end
  end
  
end