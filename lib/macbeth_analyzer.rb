require 'open-uri'
require "nokogiri"

class MacbethAnalyzer
  attr_reader :url

  def initialize
    @url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

  end

  def contents
    @contents ||= open(url).read
  end

  def analyze
    Nokogiri::XML(contents).xpath("//SPEECH[SPEAKER!='ALL']/LINE").inject(Hash.new(0)) do |recorder, line_node|
      line_node.xpath("preceding-sibling::SPEAKER").each do |speaker|
        recorder[speaker.content] += 1
      end
      recorder
    end
  end

  def output
    analyze.sort_by {|speaker, line_count| -line_count }.map do |speaker, line_count|
      "#{line_count.to_s.rjust(3, " ")} #{speaker}"
    end
  end
end