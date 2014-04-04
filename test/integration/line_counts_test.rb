require 'minitest_helper'
require_relative '../../lib/shakespeare_analyzer'
require_relative '../../lib/shakespeare_analyzer/printer'

describe ShakespeareAnalyzer do
  describe 'call' do
    subject { ShakespeareAnalyzer }
    let(:fixture) { File.expand_path('../../fixtures/story.xml', __FILE__) }
    let(:xml) { File.read(fixture) }

    it 'must print a list of speakers and line counts' do
      out, _ = capture_io do
        subject.call(Printer, xml)
      end
      out.must_equal "6 Duncan\n5 Malcolm\n"
    end
  end
end
