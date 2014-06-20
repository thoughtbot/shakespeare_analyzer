require 'net/http'
require 'nokogiri'

class MacBethParse 
	def initialize
	end
	def get_xml
		uri = URI('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
		xml_data = Net::HTTP.get(uri)
		Nokogiri.XML(xml_data)
	end
	def count_lines xml
		@speakers_lines = {}
		xml.xpath("//SPEECH").each do |i|
			speaker_name = i.css('SPEAKER').to_s.gsub('<SPEAKER>', "").gsub("</SPEAKER>","")
			lines = i.css('LINE').count
			add_lines_to_count speaker_name, lines
		end
		return @speakers_lines
	end
	def add_lines_to_count speakers_name, line_count
		if @speakers_lines[speakers_name] == nil
			@speakers_lines[speakers_name] = line_count
		 else
			current_value = @speakers_lines[speakers_name]
			@speakers_lines[speakers_name] = current_value + line_count
		end
	end
    def title_case str
    	str.split(/(\W)/).map(&:capitalize).join
    end

end

parser = MacBethParse.new
xml_data = parser.get_xml
counted_lines = parser.count_lines xml_data

sorted_counted_lines = counted_lines.sort_by {|k,v| v}.reverse

sorted_counted_lines.each_with_index do |i, index|
	puts "#{i[1]} #{parser.title_case i[0]}"
end


