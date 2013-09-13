require 'net/http'
require 'rexml/document'

class ShakespeareAnalyzer

  attr_reader :url

  def initialize url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
    @url = url
    @output = String.new
  end

  def run hash
    hash.each do |name,number_of_lines|
      @output << "#{number_of_lines}\t#{name}\n"
    end

    return @output
  end

  private

  def fetch_raw_xml_data
    Net::HTTP.get_response(URI.parse(@url)).body
  end
  
  def create_rexml_document
    @doc = REXML::Document.new(fetch_raw_xml_data)
  end



end
