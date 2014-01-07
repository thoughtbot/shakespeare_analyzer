require 'open-uri'
require 'nokogiri'

class MacbethAnalyzer
  def results
    doc.css('SPEECH').inject({}) do |results, speech|
      speaker = speech.at_css('SPEAKER').content
      lines = speech.css('LINE').length
      results[speaker] ||= 0
      results[speaker] += lines
      results
    end
  end

  def to_s
    results.sort_by(&:last).reverse.map do |speaker, lines|
      "#{lines} #{speaker}"
    end.join("\n")
  end

  def xml
    Kernel.open(source_url).read
  end

  private

  def doc
    Nokogiri::XML(xml)
  end

  def source_url
    'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
  end
end
