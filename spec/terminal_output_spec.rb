require 'spec_helper'
require_relative '../lib/terminal_output'

describe '#add_new_line' do
	it 'adds a new line to the printed output on the console' do
		output = TerminalOutput.new
		output.add_new_line "test"
		output.add_new_line "print"
		expect(output.print).to eq "test\nprint"
	end
end

describe '#print' do
	it 'displays what has been added to the buffer' do
		output = TerminalOutput.new
		output.add_new_line "foo"
		output.add_new_line "bar"
		expect(output.print).to eq "foo\nbar"
	end
end
