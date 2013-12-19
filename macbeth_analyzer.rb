require 'open-uri'
require 'nokogiri'

Nokogiri::XML(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")).search('SPEECH').inject(Hash.new(0)) do |obj, speech|
  speaker = speech.search('SPEAKER').text.capitalize
  lines   = speech.search('LINE').count
  obj.tap { |o| o[speaker] += lines }
end.sort_by {|a, b| -b}.each { |speaker, count| puts "#{count.to_s.rjust(3)}  #{speaker}" }
