require 'rubygems'
require 'minitest/autorun'
require './lib/scottish_play'


describe 'Scottish Play' do

  before do
    @scottish_play = ScottishPlay.new
    @doc = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
  end

  it "successfully fetches document" do
    parsed = @scottish_play.fetch_doc(@doc)
    parsed.type.must == 'XML'
  end
end

