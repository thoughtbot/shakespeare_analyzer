require 'nokogiri'
require 'open-uri'
require_relative 'line_counter'

include Nokogiri

class CallbackHandler < XML::SAX::Document
  def initialize
    @counter = LineCounter.new
    @parsing_speaker = false
  end

  def results
    @counter.count
  end

  def start_element(element, attributes)
    @counter.count_line if element == 'LINE'
    @counter.new_speech if element == 'SPEECH'
    @parsing_speaker = (element == 'SPEAKER')
  end

  def end_element(element)
    @parsing_speaker = false if element == 'SPEAKER'
  end

  def characters string
    @counter.add_speaker string if @parsing_speaker
  end
end
