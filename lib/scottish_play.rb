require 'open-uri'
require 'nokogiri'

class String

  def titlize 
    self[0].upcase + self[1..-1]
  end
end

class ScottishPlay

  def fetch_doc doc
    Nokogiri::XML.parse(open(doc))
  end

  def tally_personas doc
    personas = Hash.new(0)
    doc.xpath('//SPEAKER').each_with_object(personas) do |obj, hsh|
      name = obj.children.to_s.downcase
      hsh[name] += 1
    end
  end

  def get_speakers doc
    characters = Set.new
    doc.xpath('//SPEAKER').children.each do |obj|
      characters << obj.to_s.downcase
    end
  end
  
end

@scottishplay = ScottishPlay.new

parsed = @scottishplay.fetch_doc "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

report = @scottishplay.tally_personas parsed

report.each { |k,v| puts "#{k.titlize}: #{v}" }



