require 'nokogiri'
require 'active_support/core_ext/string'

class Play
  def initialize xml
    @raw_xml = xml
  end

  def characters_and_their_number_of_lines
    find_from_root(:speech, in: xml).inject Hash.new(0) do |accumulator, speech|
      accumulator[speaker_in speech] += number_of_lines_in speech
      accumulator
    end
  end

  private

  def xml
    Nokogiri::XML.parse @raw_xml
  end

  def number_of_lines_in speech
    find_tag(:line, in: speech).count
  end

  def speaker_in speech
    find_tag(:speaker, in: speech).text.titleize
  end

  def find_tag tag_name, options
    options[:in].xpath(tag_name.to_s.upcase)
  end

  def find_from_root tag_name, options
    find_tag :"//#{tag_name}", options
  end
end
