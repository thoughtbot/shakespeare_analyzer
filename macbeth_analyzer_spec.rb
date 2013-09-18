require 'minitest'
require 'minitest/autorun'
require_relative 'lib/macbeth_analyzer'

class TestMacbethAnalyzer < MiniTest::Test

  describe '#load_file' do
    def setup
      @ma = MacbethAnalyzer.new
    end
    def test_load_file
      xml_doc = @ma.load_file
      refute_nil(xml_doc)
    end
    def test_load_file_2
      xml_doc = @ma.load_file
      assert xml_doc.instance_of?(Nokogiri::HTML::Document), "Expected #{xml_doc.inspect} to be an instance of #{Nokogiri::HTML::Document}, not #{xml_doc.class}"
    end
  end

  describe "#parse_counts" do
    def setup
      @ma = MacbethAnalyzer.new
    end
    def test_parse_returns_one_speaker
      line_count = @ma.parse_counts(Nokogiri::XML("<scene><speech><speaker>A</speaker><line>B</line></speech></scene>"))
      assert_equal( line_count.count, 1 )
    end
    def test_parse_returns_one_speaker_one_line
      line_count = @ma.parse_counts(Nokogiri::XML("<scene><speech><speaker>A</speaker><line>B</line></speech></scene>"))
      assert_equal( line_count["A"], 1 )
    end
    def test_parse_returns_one_speaker_two_lines
      line_count = @ma.parse_counts(Nokogiri::XML("<scene><speech><speaker>A</speaker><line>B</line><line>C</line></speech></scene>"))
      assert_equal( line_count["A"], 2 )
    end
    def test_parse_returns_two_speakers
      line_count = @ma.parse_counts(Nokogiri::XML("<scene><speech><speaker>A</speaker><line>B</line></speech><speech><speaker>C</speaker><line>D</line></speech></scene>"))
      assert_equal( line_count.count, 2 )
    end
  end

  describe "#display" do
    def setup
      @ma = MacbethAnalyzer.new
    end
    def test_display
      output = capture_io do
        @ma.display({'A' => 1})
      end
      assert_equal ["1 A\n",""], output
    end
    def test_display_sort
      output = capture_io do
        @ma.display({'A' => 1, 'B' => 2})
      end
      assert_equal ["2 B\n1 A\n", ""], output
    end
  end
end

