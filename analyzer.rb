require_relative 'lib/http_content.rb'
require_relative 'lib/shakespeare_analyzer'
macbeth_url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
content = HttpContent.new(macbeth_url)
analyzer = ShakespeareAnalyzer.new(content.data)
analyzer.analyze
result = analyzer.result
analyzer.print_result