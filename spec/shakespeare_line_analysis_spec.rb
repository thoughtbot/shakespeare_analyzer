require 'spec_helper'
require_relative '../lib/terminal_output'
require_relative '../lib/shakespeare_line_analysis'

describe '#print_character_line_count' do
	it 'prints the number of lines for each character' do
		source = File.open('spec/sample_data.xml')
		output = TerminalOutput.new
		analyzer = ShakespeareLineAnalysis.new(source, output)
		results = analyzer.print_character_line_count
		expect(results).to eq "11 Macbeth\n5 Malcolm\n2 All"
	end
end
