require 'net/http'
require 'nokogiri'

class ShakespearAnalyzer 
  def initialize uri
    @uri = uri
  end
  def get_xml
    uri = URI(@uri)
    xml_data = Net::HTTP.get(uri)
    Nokogiri.XML(xml_data)
  end
  def count_lines xml
    @speakers_lines = {}
    xml.css("//SPEECH").each do |i|
      speaker_name = i.css('SPEAKER').text
      lines = i.css('LINE').count
      add_lines_to_count speaker_name, lines
    end
    @speakers_lines
  end
  def add_lines_to_count speakers_name, line_count
    if @speakers_lines[speakers_name] == nil
      @speakers_lines[speakers_name] = line_count
     else
      current_value = @speakers_lines[speakers_name]
      @speakers_lines[speakers_name] = current_value + line_count
    end
  end
    def title_case str
      str.split(/(\W)/).map(&:capitalize).join
    end
end
