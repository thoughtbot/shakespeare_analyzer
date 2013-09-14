require_relative = "../lib/xml_parser"

class ShakespeareAnalyzer

  MACBETH_XML = "macbeth.xml"

  attr_accessor :xml

  def initialize xml = MACBETH_XML
    @xml = xml
  end
  
  def start
    @doc = XmlParser.new(@xml).create_rexml_document
    create_speakers_and_lines_hash
    sort_speakers_by_number_of_lines
    print_speakers_and_lines
  end

  private

  def create_speakers_and_lines_hash
    @speakers = Hash.new(0)
    @doc.elements.each("PLAY/ACT/SCENE/SPEECH") do |speech|
      
      @line_count = 0
      speech.elements.each("LINE") do |line|
        @line_count += 1
      end 
      
      @characters = Array.new
      speech.elements.each("SPEAKER") do |speaker|
        @characters << speaker.text
      end

      @characters.each do |character|
        @speakers[character] += @line_count
      end

    end
  end

  def sort_speakers_by_number_of_lines
    @speakers = @speakers.sort_by { | key, value | value }.reverse 
  end

  def print_speakers_and_lines
    output = String.new
    @speakers.each do |name,number_of_lines|
      output << "#{number_of_lines}\t#{name}\n"
    end

    output
  end

end

