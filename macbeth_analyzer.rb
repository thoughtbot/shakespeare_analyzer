require_relative 'lib/shakespear_analyzer'

parser = ShakespearAnalyzer.new('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
xml_data = parser.get_xml
counted_lines = parser.count_lines xml_data
sorted_counted_lines = counted_lines.sort_by {|k,v| v}.reverse

sorted_counted_lines.each_with_index do |i, index|
	puts "#{i[1]} #{parser.title_case i[0]}"
end



