require 'net/http'
require 'rexml/document'

class ShakespeareAnalyzer

  MACBETH_XML = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

  attr_reader :url

  def initialize url = MACBETH_XML
    @url = url
  end
  
  def start
    create_rexml_document
    create_speakers_and_lines_hash
    sort_speakers_by_number_of_lines
    print_speakers_and_lines
  end

  private

  def fetch_raw_xml_data
    Net::HTTP.get_response(URI.parse(@url)).body
  end
  
  def create_rexml_document
    @doc = REXML::Document.new(fetch_raw_xml_data)
  end

  def create_speakers_and_lines_hash
    @speakers = Hash.new(0)
    @doc.elements.each("PLAY/ACT/SCENE/SPEECH") do |speech|
      
      speech.elements.each("SPEAKER") do |speaker|
        @character = speaker.text
      end

      @line_count = 0
      speech.elements.each("LINE") do |line|
        @line_count += 1
      end

      @speakers[@character] += @line_count

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
