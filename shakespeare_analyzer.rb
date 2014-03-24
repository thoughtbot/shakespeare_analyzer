require 'pp'
require 'nokogiri'

class LinesParser
  def initialize(xml)
    @doc = Nokogiri::XML(xml)
  end

  def parse
    reset_stats
    @doc.xpath('//SPEECH').each do |speech_node|
      gather_speech_stats(speech_node)
    end
    stats
  end

  private

  def gather_speech_stats(speech_node)
    lines_count = lines_in_speech(speech_node)
    speakers(speech_node).each do |speaker|
      add_lines_count(speaker, lines_count)
    end
  end

  def speakers(speech_node)
    speech_node.xpath('.//SPEAKER').map(&:text)
  end

  def lines_in_speech(speech_node)
    speech_node.xpath('.//LINE').size
  end

  def add_lines_count(speaker, lines_count)
    @stats[speaker] += lines_count
  end

  def reset_stats
    @stats = Hash.new(0)
  end

  def stats
    @stats
      .map { |speaker, lines_count| SpeakerStats.new(speaker, lines_count) }
      .sort_by { |stat| -stat.lines_count }
  end
end

SpeakerStats = Class.new(Struct.new(:speaker, :lines_count))
