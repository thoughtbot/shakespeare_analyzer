require 'net/http'
require 'rexml/document'


class MacbethAnalyzer

  def initialize
    @macbeth_xml_url = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'
  end

  def get_xml_data
    @xml_data = Net::HTTP.get_response(URI.parse(@macbeth_xml_url)).body
  end

  def parse_xml_data
    @speakers = Hash.new(0)
    doc = REXML::Document.new(@xml_data)
    doc.elements.each('PLAY/ACT/SCENE/SPEECH') do | speech |

      # Maybe I can move these out to their own methods and then test them individually...
      # get_speaker_name
      speech.elements.each('SPEAKER') do | speaker |
        @speaker = speaker.text
      end

      # get_total_lines_for_speech
      @line_count = 0
      speech.elements.each('LINE') do | line |
        @line_count += 1
      end 

      # add_speaker_to_hash
      @speakers[@speaker] += @line_count

    end
  end

  def sort_speakers_by_number_of_lines
    @speakers = @speakers.sort_by { | key, value | value }.reverse 
  end

  def show_speaker_line_count
    # Is this the best way to handle running the whole file? Seems like its not.
    self.get_xml_data
    self.parse_xml_data
    self.sort_speakers_by_number_of_lines
    @speakers.each do | name, lines |
      puts "#{lines} #{name.downcase.split(" ").map(&:capitalize).join(" ")}"
    end
  end

end

analyzer = MacbethAnalyzer.new
analyzer.show_speaker_line_count
