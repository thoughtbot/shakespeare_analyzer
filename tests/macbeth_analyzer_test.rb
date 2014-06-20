require_relative "../lib/shakespear_analyzer"
require 'test/unit'
require 'nokogiri'

class TestShakespearAnalyzer< Test::Unit::TestCase

  def test_xml
   	doc = grab_xml
    assert(doc.xpath('//PLAY').empty?, "There is a problem with your XML #{doc.errors}")
  end

  def test_count_lines
  	doc = grab_xml
  	count = @xmlParser.count_lines doc
    assert(count.empty?, "No Speakers were returned. Line Count Failed" )
  end

private

  def grab_xml
    @xmlParser = ShakespearAnalyzer.new('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
    xml = @xmlParser.get_xml
    Nokogiri::XML(xml)
  end
 
end