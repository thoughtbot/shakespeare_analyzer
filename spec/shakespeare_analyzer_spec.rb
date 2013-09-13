require 'spec_helper'
require 'shakespeare_analyzer'
require 'stringio'

describe ShakespeareAnalyzer do
  describe '#initialize' do
    it 'reads provided URI and stores its content to @file_content' do
      stub_request(:get, 'http://www.example.com/test_file.txt').to_return(body: 'This is just a test file!')
      analyzer = ShakespeareAnalyzer.new('http://www.example.com/test_file.txt')
      expect(analyzer.file_content).to eq 'This is just a test file!'
    end
  end

  describe '#print_speakers_sorted_by_line_count' do
    it 'prints list of speakers sorted by line count' do
      test_file = File.dirname(__FILE__) + '/test_files/test.xml'
      stub_request(:get, 'http://www.example.com/test.xml').to_return(body: File.read(test_file))
      analyzer = ShakespeareAnalyzer.new('http://www.example.com/test.xml')
      output = capture_stdout { analyzer.print_speakers_sorted_by_line_count }
      expect(output).to eq "3 ThreeLiner\n2 TwoLiner\n1 OneLiner\n"
    end
  end
end

def capture_stdout &block
  old_stdout = $stdout
  fake_stdout = StringIO.new
  $stdout = fake_stdout
  block.call
  fake_stdout.string
ensure
  $stdout = old_stdout
end
