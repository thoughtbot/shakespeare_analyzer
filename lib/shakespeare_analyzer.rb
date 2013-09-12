require 'net/http'

class ShakespeareAnalyzer
  attr_accessor :file_content

  def initialize(uri)
   @file_content = get_content_from_uri(uri)
  end

  private

  def get_content_from_uri(uri)
    Net::HTTP.get_response(URI.parse(uri)).body
  end
end
