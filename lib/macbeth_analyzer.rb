require 'open-uri'
require "nokogiri"

class MacbethAnalyzer
  attr_accessor :url, :contents

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
          lines: speech.css("LINE").map {|line| line.content }
        }
      end
    end 
  end

  def analyze
    speeches.inject({}) do |recorder, speech|
      unless recorder.has_key? speech[:speaker]
        recorder[speech[:speaker]] = 0
      end
      recorder[speech[:speaker]] += speech[:lines].length
      recorder
    end
  end

  def output
    analyze.sort_by {|speaker, line_count| line_count * -1 }.map do |speaker, line_count|
      "#{line_count.to_s.rjust(3, " ")} #{speaker}"
    end
  end
end