require_relative '../lib/shakespeare_analyzer.rb'
require 'minitest/autorun'
require_relative 'test_helper'
require_relative 'play_test'
require_relative 'speech_test'

class TestShakespeareAnalyzer < MiniTest::Unit::TestCase
    def setup
        @analyzer = ShakespeareAnalyzer.new example_play
    end

    def test_lines_per_speaker_outputs_data_correctly
        assert_equal "2\tFox 1\n2\tFox 2\n", @analyzer.lines_per_speaker,
            "lines_per_speaker output didn't match expected"
    end
end
