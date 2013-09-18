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
          speakers: speech.css("SPEAKER").map { |speaker| speaker.content },
          line_count: speech.css("LINE").count
        }
      end
    end 
  end

  def analyze
    speeches.inject(Hash.new(0)) do |recorder, speech|
      speech[:speakers].each do |speaker|
        recorder[speaker] += speech[:line_count] unless speaker == 'ALL'
      end
      recorder
    end
  end

  def one_step_analyze
    Nokogiri::XML(contents).xpath("//SPEECH[SPEAKER!='ALL']/LINE").inject(Hash.new(0)) do |recorder, line_node|
      line_node.xpath("preceding-sibling::SPEAKER").each do |speaker|
        recorder[speaker.content] += 1
      end
      recorder
    end
  end

  def output(one_step: false)
    analyzed = (one_step) ? one_step_analyze : analyze

    analyzed.sort_by {|speaker, line_count| line_count * -1 }.map do |speaker, line_count|
      "#{line_count.to_s.rjust(3, " ")} #{speaker}"
    end
  end
end