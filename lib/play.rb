require 'nokogiri'
require 'active_support/core_ext/string'

class Play
  def initialize xml
    @raw_xml = xml
  end

  def characters_and_their_number_of_lines
    find_element_from_root(:speech, in: xml).inject Hash.new(0) do |accumulator, speech|
      accumulator[speaker_in speech] += number_of_lines_in speech
      accumulator
    end
  end

  private

  def xml
    Nokogiri::XML.parse @raw_xml
  end

  def number_of_lines_in speech
    find_element(:line, in: speech).count
  end

  def speaker_in speech
    find_element(:speaker, in: speech).text.titleize
  end

  def find_element element_name, options
    options[:in].xpath(element_name.to_s.upcase)
  end

  def find_element_from_root element_name, options
    find_element :"//#{element_name}", options
  end
end
