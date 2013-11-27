require_relative '../lib/shakespeare_analyzer.rb'
require 'minitest/autorun'
require_relative 'test_helper'
require_relative 'play_test'
require_relative 'speech_test'

class TestShakespeareAnalyzer < MiniTest::Unit::TestCase
    def setup
        @analyzer = ShakespeareAnalyzer.new example_play
    end


end
