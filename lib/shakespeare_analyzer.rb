require 'open-uri'
require_relative 'xml_parser'

class ShakespeareAnalyzer
  def initialize(uri)
    @file_content = get_content_from_uri(uri)
    print_speakers_sorted_by_line_count
  end

  private

  def get_content_from_uri(uri)
    open(uri, proxy: ENV['http_proxy']).read
  end

  def speakers_sorted_by_line_count
    speakers = {}
    xml_parser.speakers.each do |speaker|
      speakers[speaker] = xml_parser.lines_by_speaker(speaker)
    end
    speakers.sort_by { |_key, value| value }.reverse
  end

  def xml_parser
    XmlParser.new(@file_content)
  end

  def print_speakers_sorted_by_line_count
    speakers_sorted_by_line_count.each do |speaker, lines|
      puts "#{lines} #{speaker}"
    end
  end
end

if __FILE__ == $0
  ShakespeareAnalyzer.new('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
end
