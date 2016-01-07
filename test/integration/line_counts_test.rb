require 'minitest_helper'
require 'shakespeare_analyzer'

describe ShakespeareAnalyzer do
  describe 'call' do
    subject { ShakespeareAnalyzer }
    let(:fixture) { File.expand_path('../../fixtures/story.xml', __FILE__) }
    let(:xml) { File.read(fixture) }

    it 'must print a list of speakers and line counts' do
      subject.call(xml).must_equal "6 Duncan\n5 Malcolm\n"
    end
  end
end
