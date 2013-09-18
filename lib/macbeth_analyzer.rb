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

  def speeches
    if @speeches
      @speeches
    else
      @speeches = Nokogiri::XML(contents).css("SPEECH").map do |speech|
        {
          speaker: speech.at_css("SPEAKER").content,
          line_count: speech.css("LINE").count
        }
      end
    end 
  end

  def analyze
    speeches.inject(Hash.new(0)) do |recorder, speech|
      recorder[speech[:speaker]] += speech[:line_count] unless speech[:speaker] == 'ALL'
      recorder
    end
  end

  def output
    analyze.sort_by {|speaker, line_count| line_count * -1 }.map do |speaker, line_count|
      "#{line_count.to_s.rjust(3, " ")} #{speaker}"
    end
  end
end