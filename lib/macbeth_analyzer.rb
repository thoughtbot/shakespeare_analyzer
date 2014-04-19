require 'terminal_output'
require 'nokogiri'

class MacbethAnalyzer
	def initialize(source)
		@speakers = Hash.new
		@xml_doc = Nokogiri::XML(source)
		@output = TerminalOutput.new

	end

	def analyze
		parse_speakers

		# sort it so that they are in descending order by key (line count)
		@speakers = Hash[@speakers.sort_by { |key, value| value }.reverse]

		@speakers.each do |key, value|
			@output.add_new_line "#{value} #{key.capitalize}"
		end

		@output.print
	end

	private 

	def parse_speakers
		@xml_doc.xpath("//SPEAKER").each do |node|
			siblings = @xml_doc.search("SPEAKER[text()='#{node.content}'] ~ *").map &:text
			@speakers[node.content] = siblings.length
		end
	end
end
