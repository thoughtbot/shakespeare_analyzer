require 'open-uri'
require_relative 'shakespeare_line_analysis'
require_relative 'terminal_output'

# This is the entry class for the analysis
# it is doing a bit too much, but, being the entry point, 
# something has to have the knowledge of what to send where
class MacbethLineAnalyzer
	WEB_SOURCE_LOCATION = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"

	def initialize(source = nil)
		source ||= File.read(open(WEB_SOURCE_LOCATION))
		@analyzer = ShakespeareLineAnalysis.new(source, TerminalOutput.new)
	end

	def analyze
		@analyzer.print_character_line_count
	end

	def default_source_location
		WEB_SOURCE_LOCATION
	end
end
