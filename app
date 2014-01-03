#!/usr/bin/env ruby

require_relative 'lib/shakespeare_analyzer.rb'

MACBETH_URL = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
HAMLET_URL = "http://www.ibiblio.org/xml/examples/shakespeare/hamlet.xml"

macbeth_analyzer = ShakespeareAnalyzer.new MACBETH_URL
hamlet_analyzer = ShakespeareAnalyzer.new HAMLET_URL

puts "Lines	Speaker"
puts "Macbeth"
print macbeth_analyzer.lines_per_speaker

puts "Hamlet"
print hamlet_analyzer.lines_per_speaker
