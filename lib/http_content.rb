require 'open-uri'
require_relative 'content'
require 'nokogiri'
class HttpContent < Content
  def get_content_from_source
    Nokogiri::XML(open(@source))
  end
end