require 'pp'
require 'nokogiri'
require 'net/http'
require 'uri'

class ShakespeareAnalyzer
  def initialize(file=nil)
    @file = file
    if FileTest.exist?(@file) then
      ## Processing a local file
      if File.size(@file) == 0 then
        puts "Empty input file; terminating"
        @file = nil
        return nil
      end
      return true
    else
      ## Must be a remote file
      return get_http_file
    end
  end

  def get_http_file
    uri = URI(@file)
    if uri.scheme != 'http'
      puts "Not an HTTP file; terminating"
      @file = nil
      return nil
    end
    @file = 'play.xml'
    Net::HTTP.start(uri.host) do |http|
      resp = http.get(uri.path)
      open(@file, 'wb') do |file|
        file.write(resp.body)
      end
    end
    true
  end

  def analyze
    return nil if @file.nil?
    doc = Nokogiri::XML(open(@file)) { |config| config.noerror }
    @persona = {}
    doc.css('PERSONA').each do |p|
      pname = p.children.text.tr('"','')
      @persona[pname] = 0
    end
    doc.css('SPEECH').each do |speech|
      speakers = speech.css('SPEAKER').each do |s|
        speaker = s.children.text.tr('"','')
        ## Sometimes the speaker is 'ALL', but that depends on who's on stage...
        if speaker == 'ALL' then
          #@persona.each { |k,v| @persona[k] += 1 }
        else
          ### Turns out there are speakers without @persona!
          @persona[speaker] = 0 if @persona[speaker].nil?
          speech.css('LINE').each do |line|
            @persona[speaker] += 1
          end
        end
      end
    end
  end

  def list_by_speaker_count
    return nil if @file.nil?
    sorted_output = (@persona.sort_by {|k,v| v}).reverse
    sorted_output.each do |a| 
      name = (a[0].split(' ').map {|n| n.capitalize }).join(" ")
      puts "#{a[1]} #{name}" 
    end
  end
end
