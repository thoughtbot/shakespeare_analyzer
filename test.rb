require 'net/http'
require 'rexml/document'

# Web search for "madonna"
url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

# get the XML data as a string
xml_data = Net::HTTP.get_response(URI.parse(url)).body

# extract event information
doc = REXML::Document.new(xml_data)
all_speakers = []

doc.elements.each('PLAY/ACT/SCENE/SPEECH/SPEAKER') do | speaker |
  all_speakers << speaker.text
end

speakers = Hash.new(0)
all_speakers.each do | name | 
  speakers[name] += 1
end

puts speakers
