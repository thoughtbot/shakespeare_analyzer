require 'terminal_output'
require 'shakespeare_parser'
require 'nokogiri'

class MacbethAnalyzer
	def initialize(source)
		@parser = ShakespeareParser.new(source)
		@output = TerminalOutput.new
		@formatter = OutputFormatter.new(@output)
	end

	def analyze
		speakers = @parser.speaker_line_count

		@formatter.print_values_descending(speakers)

		@output.print
	end
end
