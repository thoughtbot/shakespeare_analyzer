require 'rexml/document'

class ShakespeareAnalyzer

  def initialize options = {}
    @downloader = options[:downloader]
    @file = REXML::Document.new get_file
  end

  def print_lines
    in_descending_order(read_lines).each do |key, value|
      puts "#{key}: #{value} lines"
    end
  end

  private

  def get_file
    xml = @downloader.download_file
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
