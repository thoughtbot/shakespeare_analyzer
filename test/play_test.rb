class TestPlay < MiniTest::Unit::TestCase
    def setup
        @play = Play.new(example_play)
    end

    def test_play_initializes_with_file_path
        play = Play.new(example_play_path)
        assert play.document, "play was unable to initialize when given a file path as a string"
    end

    def test_play_initializes_with_file_instance
        assert @play.document, "play was unable to initialize when given a File object"
    end

#  This passed, but my internet sucks, so I don't
#  want to fetch the play every time I run my tests
    def test_play_initializes_with_url
        play = Play.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
        assert play.document, "play was unable to initialize when given a url"
    end

    def test_speeches_initializes_an_array_of_speech_objects
        speeches = @play.speeches
        assert speeches.is_a? Array
        assert speeches.first.is_a? Speech
    end
end
