require 'nokogiri'
class Content
  attr_accessor :data,:source
  def initialize(source)
    @source = source
    @data = get_content_from_source
  end
  
  def get_content_from_source
  end
end