#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

class MacbethAnalyzer
  def initialize(play)
    @play = Nokogiri::XML(play)
  end

  def line_counts
    speeches = get_speeches
    speeches.reduce(Hash.new(0)) do |line_counts, speech|
      speakers = get_speakers(speech)
      line_count = get_line_count(speech)
      speakers.each { |speaker| line_counts[speaker] += line_count }
      line_counts
    end
  end

  def formatted_line_counts
    sorted_line_counts = line_counts.sort_by { |speaker, count| -count }
    max_count = sorted_line_counts.first[1]
    max_count_length = max_count.to_s.length

    sorted_line_counts.map do |speaker, count|
      formatted_count = count.to_s.ljust(max_count_length)
      "#{formatted_count} #{speaker}"
    end.join("\n")
  end

  private

  def get_speeches
    @play.xpath("//SPEECH")
  end

  def get_speakers(speech)
    speech.xpath("SPEAKER").map(&:text)
  end

  def get_line_count(speech)
    line_count = speech.xpath("LINE").count
  end
end

if __FILE__ == $PROGRAM_NAME
  DEFAULT_URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  play = open(ARGV[0] || DEFAULT_URL).read
  puts MacbethAnalyzer.new(play).formatted_line_counts
end
