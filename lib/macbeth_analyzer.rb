
class MacbethAnalyzer
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
    line_count = Hash.new(0)
    speeches = xml_doc.css('speech')
    speeches.each do |speech|
      speaker = speech.css('speaker').text
      count = speech.css('line').count
      line_count[speaker] += count if speaker != 'ALL'
    end
    line_count
  end

  def display(line_counts)
    line_counts.sort_by{|_key, value| value}.reverse.each do |v|
      puts "#{v[1]} #{v[0]}"
    end
  end
end

#MacbethAnalyzer.new.run
