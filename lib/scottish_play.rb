require 'open-uri'
require 'nokogiri'

class ScottishPlay

  def initialize(url)
    @url = url
  end

  def analyze
    parsed = parse_doc @url
    tally_personas parsed
  end

  def parse_doc doc
    Nokogiri::XML.parse(open(doc))
  end

  def tally_personas doc
    doc.xpath('//SPEAKER').each_with_object(Hash.new(0)) do |obj, hsh|
      name = obj.children.to_s.downcase
      hsh[name] += 1
    end
  end
  
end

