require 'terminal_output'
require 'shakespeare_parser'
require 'nokogiri'

class MacbethAnalyzer
	def initialize(source)
		@parser = ShakespeareParser.new(source)
		@output = TerminalOutput.new
	end

	def analyze
		speakers = @parser.speaker_line_count

		# sort it so that they are in descending order by key (line count)
		speakers = Hash[speakers.sort_by { |key, value| value }.reverse]

		speakers.each do |key, value|
			@output.add_new_line "#{value} #{key.capitalize}"
		end

		@output.print
	end
end
