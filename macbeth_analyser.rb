require 'open-uri'
require_relative 'lib/shakespeare_analyser'

text = open('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')

results = ShakespeareAnalyser.new(text.read).run

longest_name = results.keys.map(&:length).max

results.each do |character, line_count|
  # format with padding (the - indicates left align)
  printf("%-#{longest_name}s %s\n", character, line_count)
end
