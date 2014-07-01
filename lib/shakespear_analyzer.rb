require 'open-uri'
require 'nokogiri'

class ShakespearAnalyzer 
  def initialize uri
    @uri = URI(uri)
  end
  def get_xml
    xml_data = open(@uri)
    Nokogiri.XML(xml_data)
  end
  def count_lines xml
    @speakers_lines = Hash.new(0)
    xml.css("//SPEECH").each do |i|
      speaker_name = i.css('SPEAKER').text
      lines = i.css('LINE').count
      @speakers_lines[speaker_name] += lines
    end
    @speakers_lines
  end
  def title_case str
    str.split(/(\W)/).map(&:capitalize).join
  end
end
