require_relative 'lib/shakespeare_analyzer.rb'

@analyzer = ShakespeareAnalyzer.new "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
@analyzer.print_lines_per_speaker!
