require 'xml_parser'
require 'open-uri'

class ShakespeareAnalyzer
  attr_accessor :file_content

  def initialize(uri)
   @file_content = get_content_from_uri(uri)
  end

  def print_speakers_sorted_by_line_count
    speakers_sorted_by_line_count.each do |speaker, lines|
      puts "#{lines} #{speaker}"
    end
  end

  private

  def get_content_from_uri(uri)
    open(uri, proxy: ENV['http_proxy']).read
  end

  def speakers_sorted_by_line_count
    speakers = {}
    xml_parser = XmlParser.new(@file_content)
    xml_parser.speakers.each do |speaker|
      speakers[speaker] = xml_parser.lines_by_speaker(speaker)
    end
    speakers.sort_by { |_key, value| value }.reverse
  end
end
