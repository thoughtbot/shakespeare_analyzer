require 'spec_helper'
require_relative '../lib/macbeth_line_analyzer'

describe 'displays number of total lines spoken by characters in Macbeth' do
	it 'prints the correct number of lines for the characters with the specified document' do
		source = File.read('spec/sample_data.xml')
		analyzer = MacbethLineAnalyzer.new(source)
		results = analyzer.analyze
		expect(results).to eq "11 Macbeth\n5 Malcolm\n2 All"
	end

	it 'has a default source pointing to a web location' do
		analyzer = MacbethLineAnalyzer.new
		expect(analyzer.default_source_location).to eq "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
	end

	it 'returns an error for malformed xml input' do
		analyzer = MacbethLineAnalyzer.new("asdsada")
		expect{analyzer.analyze}.to raise_error 
	end
end
