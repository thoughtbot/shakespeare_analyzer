require 'spec_helper'
require_relative '../lib/terminal_output'
require_relative '../lib/output_formatter'

describe '.print_values_descending' do
	it 'fills output in correct order' do
		output_buffer = TerminalOutput.new
		formatter = OutputFormatter.new(output_buffer)
		h = Hash["mark" => 100, "steve" => 12, "kevin" => 200]
		formatter.print_values_descending(h)
		expect(output_buffer.print).to eq "200 Kevin\n100 Mark\n12 Steve"
	end
end
