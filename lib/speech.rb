class Speech
    attr_accessor :speakers, :lines

    # speech_xml is a Nokogiri xml object
    def initialize(speech_xml)
        @speakers = speech_xml.css('SPEAKER').map do |speaker|
            # I'd do map(&:content), but I hate CAPSLOCKED SPEAKER NAMES
            speaker.content.downcase.split.map(&:capitalize).join(' ')
        end
        @lines = speech_xml.css('LINE').map(&:content)
    end
end
