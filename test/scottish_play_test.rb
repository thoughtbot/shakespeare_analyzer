require 'rubygems'
require 'net/http'
require 'minitest/autorun'
require 'minitest/spec'
require_relative '../lib/scottish_play'


describe ScottishPlay do

  before do
    @analyzer = ScottishPlay.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
    @result = {"first witch"=>23,
               "second witch"=>15,
               "third witch"=>13,
               "all"=>13,
               "duncan"=>18,
               "malcolm"=>40,
               "sergeant"=>3,
               "lennox"=>22,
               "ross"=>39,
               "macbeth"=>146,
               "banquo"=>33,
               "angus"=>4,
               "lady macbeth"=>59,
               "messenger"=>6,
               "fleance"=>2,
               "porter"=>4,
               "macduff"=>59,
               "donalbain"=>3,
               "old man"=>4,
               "attendant"=>1,
               "first murderer"=>19,
               "second murderer"=>6,
               "both murderers"=>2,
               "servant"=>5,
               "third murderer"=>6,
               "lords"=>3,
               "hecate"=>2,
               "lord"=>3,
               "first apparition"=>1,
               "second apparition"=>2,
               "third apparition"=>1,
               "lady macduff"=>19,
               "son"=>14,
               "doctor"=>20,
               "gentlewoman"=>11,
               "menteith"=>5,
               "caithness"=>3,
               "seyton"=>5,
               "siward"=>11,
               "soldiers"=>1,
               "young siward"=>4
               }
  end

  it "analyzes analyzes text" do
    result = @analyzer.analyze
    assert_equal result, @result 
  end
end

