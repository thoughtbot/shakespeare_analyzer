require 'open-uri'
require_relative 'xml_parser'

class ShakespeareAnalyzer
  def initialize(uri)
    @file_content = get_content_from_uri(uri)
  end

  def run
    print_speakers_sorted_by_line_count
  end

  private

  def get_content_from_uri(uri)
    open(uri, proxy: ENV['http_proxy']).read
  end

  def print_speakers_sorted_by_line_count
    speakers_sorted_by_line_count.each do |speaker, lines|
      puts "#{lines} #{speaker}"
    end
  end

  def speakers_sorted_by_line_count
    speakers.sort_by { |_key, value| value }.reverse
  end

  def speakers
    Hash[*xml_parser.speakers.map { |s| [s, xml_parser.count_lines_by_speaker(s)] }.flatten]
  end

  def xml_parser
    @_xml_parser ||= XmlParser.new(@file_content)
  end
end
