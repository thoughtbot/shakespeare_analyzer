require 'nokogiri'
require 'content'
class StringContent < Content
  def get_content_from_source
    Nokogiri::XML(@source)
  end
end