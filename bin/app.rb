require_relative "../lib/xml_parser"
require_relative "../lib/shakespeare_analyzer"

analyzer = ShakespeareAnalyzer.new
puts analyzer.start
