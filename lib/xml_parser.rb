require 'net/http'
require 'rexml/document'

class XmlParser
  
  def initialize xml
    @xml = xml
  end
  
  def create_rexml_document
    @doc = REXML::Document.new xml_is_a_file? ? read_xml_file : fetch_raw_xml_data
  end

  def xml_is_a_file?
    File.exist? @xml
  end

  def read_xml_file
    File.read @xml
  end

  def fetch_raw_xml_data
    Net::HTTP.get_response(URI.parse(@xml)).body
  end

end


