require 'rubygems'
require 'nokogiri'
require 'open-uri' # https://ruby-doc.org/stdlib-2.1.0/libdoc/open-uri/rdoc/OpenURI.html
# => Tempfile (http://ruby-doc.org/stdlib-1.9.3/libdoc/tempfile/rdoc/Tempfile.html)

class MacbethAnalyzer

  def initialize(script_txt)
    script_txt = Nokogiri::XML(script_txt) { |config| config.strict.noblanks }
    lines = get_speaking_lines(script_txt)
    @lines_per_character = count_lines(lines)
  end

  def get_speaking_lines(script)
    script.xpath("//SPEECH")
  end

  def count_lines(lines)
    tally = Hash.new(0)
    lines.each do |line|
      speaker  = line.children.first.content
      line_count = line.children.count - 1
      tally[speaker] += line_count
    end
    tally.reject { |k| k =~ /all/i }
  end

  def report_tally
    @lines_per_character.sort_by { |k, v| -v }.collect { |t| t.reverse.join ' ' }.join("\n")
  end
end


xml_download = open "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
puts MacbethAnalyzer.new(xml_download).report_tally
