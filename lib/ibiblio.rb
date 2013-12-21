require 'open-uri'

module Catalogue
  def find(play)
    raise NotImplementedError
  end
end

class Ibiblio
  extend Catalogue

  URI = "http://www.ibiblio.org/xml/examples/shakespeare/%{play}.xml"

  def self.find(play)
    open(URI % {:play => play.downcase})
  end
end
