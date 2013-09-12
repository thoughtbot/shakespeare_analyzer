require 'rexml/document'

class ShakespeareAnalyzer

  attr_accessor :output

  def initialize options = {}
    @downloader = options[:downloader]
    @file = REXML::Document.new get_file
  end


  def print_lines
    read_lines.sort_by{|k,v| -v}.each do |key, value|
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
      characters[line.parent.elements[1].text] += 1
    end
    characters
  end

end
