require_relative 'shakespeare_analyzer'

macbeth_url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
doc = Nokogiri::XML(open(macbeth_url))
shakespeare_analyzer = ShakespeareAnalyzer.new(doc)
shakespeare_analyzer.analyze
result = shakespeare_analyzer.result
shakespeare_analyzer.print_result