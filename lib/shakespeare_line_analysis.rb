require 'shakespeare_parser'
require 'output_formatter'

class ShakespeareLineAnalysis
	def initialize(source, output)
		@source = source
		@output = output
	end

	def print_character_line_count
		parser = ShakespeareParser.new(@source)
		speakers = parser.speaker_line_count

		formatter = OutputFormatter.new(@output)
		formatter.print_values_descending(speakers)

		@output.print
	end
end
