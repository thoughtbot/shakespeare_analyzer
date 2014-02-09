require 'open-uri'
require_relative './lib/shakespeare_analyzer.rb'

xml_data = open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")

speakers = ShakespeareAnalyzer.new(xml_data).run

speakers.sort_by { |_key, value| -value }.each do |speaker, lines|
  puts "\t#{lines} #{speaker}"
end