require 'rexml/document'

class ShakespeareAnalyzer

  def initialize options = {}
    @xml_provider = options[:xml_provider]
    @file = REXML::Document.new xml
  end

  def print_lines
    in_descending_order(read_lines).each do |key, value|
      puts "#{key}: #{value} lines"
    end
  end

  private

  def xml
    @xml_provider.get_xml
  end

  def read_lines 
    characters = Hash.new 0
    @file.elements.each("/PLAY//LINE") do |line|
      characters[current_speaker(line)] += 1
    end
    characters
  end

  def current_speaker line
    line.parent.elements[1].text
  end

  def in_descending_order characters
    characters.sort_by { |key, value| -value }
  end

end
