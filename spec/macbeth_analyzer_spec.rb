require 'spec_helper'
require_relative '../lib/macbeth_analyzer'

describe 'displays number of total lines spoken by characters in Macbeth' do
	it 'prints the number with the name' do
		output = StringIO.new
		analyzer = MacbethAnalyzer.new(output)
		analyzer.analyze
		output.seek(0)
		expect(output.read.chomp).to eq "12 Macbeth\n4 Banquo\n3 Duncan"
	end
end
