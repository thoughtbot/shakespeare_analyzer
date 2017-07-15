require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class MacbethAnalyzer
  DEFAULT_URL = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
  SPEECH = "//SPEECH"
  ALL_REGEXP = /all/i

  attr_accessor :nokogiri_script, :lines, :lines_per_character

  def initialize(script:nil)
    self.nokogiri_script = script || get_script(DEFAULT_URL)
    self.lines = get_speaking_lines
    self.lines_per_character = count_lines
  end

  def get_script(url)
    Nokogiri::XML.parse(open(url)) { |config| config.strict.noblanks }
  end

  def get_speaking_lines
    nokogiri_script.xpath(SPEECH)
  end

  def count_lines
    lines.each_with_object(Hash.new(0)) do |line, memo|
      speaker, count = line.children.first.content, line.children.count - 1
      memo[speaker] += count
    end
  end

  def report
    lines_per_character
      .reject { |k, v| k =~ ALL_REGEXP }
      .sort_by { |k, v| -v }
      .collect(&:reverse)
      .collect { |t| t.join(' ') }
      .join("\n")
  end

end

puts MacbethAnalyzer.new().report
