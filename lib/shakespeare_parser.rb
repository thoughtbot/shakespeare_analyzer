require 'nokogiri'

class ShakespeareParser
	def initialize(xml_source_string)
		@xml_doc = Nokogiri::XML(xml_source_string) { |config| config.strict }
	end

	def speaker_line_count
		speakers = Hash.new

		@xml_doc.xpath("//SPEAKER").each do |node|
			siblings = @xml_doc.search("SPEAKER[text()='#{node.content}'] ~ *").map &:text
			speakers[node.content] = siblings.length
		end

		speakers
	end
end
