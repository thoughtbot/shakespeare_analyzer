require 'content'
require 'nokogiri'
class FileContent < Content
  def get_content_from_source
    f = File.open(@source)
    Nokogiri::XML(f)
  end
end