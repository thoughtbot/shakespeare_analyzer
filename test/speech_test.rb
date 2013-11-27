require 'nokogiri'

class TestSpeech < MiniTest::Unit::TestCase
    def setup
        @speech = Speech.new(speech_xml.first)
    end

    def test_speech_initializes_with_attributes
        assert @speech.speakers && @speech.lines
    end

    def test_speakers_are_properly_capitalized
        assert_equal "Fox 1", @speech.speakers.first
    end

    def test_lines_are_properly_added
        assert_equal 1, @speech.lines.count
    end

    def speech_xml
        nk_example_play.css('SPEECH')
    end
end
