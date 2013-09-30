require 'rubygems'
require 'minitest/autorun'
require_relative '../lib/scottish_play'


describe 'Scottish Play' do

  before do
    @scottish_play = ScottishPlay.new
    @doc = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  end

  it "successfully fetches document" do
    parsed = @scottish_play.fetch_doc(@doc)
    assert_equal parsed.type, 'XML'
  end
end

