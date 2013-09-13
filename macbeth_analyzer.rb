
class Macbeth_Analyzer
  require 'net/http'
  require 'open-uri'
  require 'nokogiri'

  def run
    line_counts = parse_counts(load_file)
    display(line_counts)
  end

  def load_file
    Nokogiri::HTML(open('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'))
  end

  def parse_counts(xml_doc)
    line_count = {}
    speeches = xml_doc.css('speech')
    speeches.each do |speech|
      speaker = speech.css('speaker').text
      count = speech.css('line').count

      if speaker == 'ALL'
        #line_count.each_key { |k| line_count[k] += 1 }
      elsif line_count.has_key?(speaker)
        line_count[speaker] += count
      else
        line_count[speaker] = count
      end
    end
    line_count
  end

  def display(line_counts)
    line_counts.sort_by{|_key, value| value}.reverse.each do |v|
      puts "#{v[1]} #{v[0]}"
    end
  end
end

Macbeth_Analyzer.new.run
