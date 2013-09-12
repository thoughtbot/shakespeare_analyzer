require 'spec_helper'
require 'shakespeare_analyzer'

describe ShakespeareAnalyzer do
  describe '#initialize' do
    it 'reads provided URI and stores its content to @file_content' do
      stub_request(:get, 'http://www.example.com/test_file.txt').to_return(body: 'This is just a test file!')
      analyzer = ShakespeareAnalyzer.new('http://www.example.com/test_file.txt')
      expect(analyzer.file_content).to eq 'This is just a test file!'
    end
  end
end
