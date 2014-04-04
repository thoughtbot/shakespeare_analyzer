require 'nokogiri'
require 'values'

require_relative 'shakespeare_analyzer/speaker_counts_from_xml'
require_relative 'shakespeare_analyzer/speaker_aggregator'

module ShakespeareAnalyzer
  extend self

  def call(printer, xml)
    counts    = SpeakerCountsFromXml.call(xml)
    aggregate = SpeakerAggregator.call(counts)
    printer.call(aggregate)
  end
end
