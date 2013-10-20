require 'pp'
require 'nokogiri'
require 'net/http'
require 'uri'

class ShakespeareAnalyzer
  def initialize(file)
    @file = file
    @persona = {}
  end

  def analyze
    #TODO: Probably better name of 'parse'
    @file = checked_file_for_open
    doc = Nokogiri::XML(open(@file)) { |config| config.noerror }
    get_persona(doc)
    analyze_speeches(doc)
  end

  def get_persona(doc)
    doc.css('PERSONA').each do |p|
      pname = p.children.text.tr('"','')
      @persona[pname] = 0
    end
  end

  def analyze_speeches(doc)
    doc.css('SPEECH').each do |speech|
      speakers = speech.css('SPEAKER').each do |s|
        speaker = s.children.text.tr('"','')
        ## Sometimes the speaker is 'ALL', but who that is depends on who's on stage...
        ## Ignoring this for now
        ## Turns out there are speakers without @persona!
        @persona[speaker] = 0 if @persona[speaker].nil?
        speech.css('LINE').each do |line|
          @persona[speaker] += 1
        end
      end
    end
  end

  def list_by_speaker_count
    sorted_output = (@persona.sort_by {|k,v| v}).reverse
    sorted_output.each do |a| 
      name = (a[0].split(' ').map {|n| n.capitalize }).join(" ")
      puts "#{a[1]} #{name}" 
    end
  end

  def checked_file_for_open
    return @file if File.file?(@file)
    return get_http_file
  end

  def get_http_file
    uri = URI(@file)
    raise "Unreadable file" if uri.scheme != "http"
    @file = 'play.xml'
    Net::HTTP.start(uri.host) do |http|
      resp = http.get(uri.path)
      raise "Unreadable file" unless (resp.code.to_i >= 200 && resp.code.to_i <= 299)
      open(@file, 'wb') do |file|
        file.write(resp.body)
      end
    end
    @file
  end

end
