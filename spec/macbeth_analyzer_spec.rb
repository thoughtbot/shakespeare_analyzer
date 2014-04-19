require 'spec_helper'
require_relative '../lib/macbeth_analyzer'

describe 'displays number of total lines spoken by characters in Macbeth' do
	it 'prints the correct number of lines for the characters with the specified document' do
		source = File.read('spec/sample_data.xml')
		analyzer = MacbethAnalyzer.new(source)
		results = analyzer.analyze
		expect(results).to eq "11 Macbeth\n5 Malcolm\n2 All"
	end
end
