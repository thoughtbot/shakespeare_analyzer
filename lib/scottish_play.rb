require 'open-uri'
require 'nokogiri'


class ScottishPlay

  def fetch_doc doc
    parsed = Nokogiri::XML(open(doc))
  end
end



