require 'spec_helper'
require_relative '../lib/shakespeare_parser'

describe '.speaker_line_count' do
	it 'creates a hash of characters and their line numbers' do
		source = File.read('spec/sample_data.xml')
		parser = ShakespeareParser.new(source)
		result = parser.speaker_line_count
		expect(result['MACBETH']).to eq 11
		expect(result['MALCOLM']).to eq 5
	end
end
