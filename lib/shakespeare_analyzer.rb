require 'pp'
require 'nokogiri'

class ShakespeareAnalyzer
  def initialize(file)
    @file = file
  end
  def check_input
    if @file.nil? then
      puts "No input file; terminating"
      return nil
    elsif File.size(@file) == 0 then
      puts "Empty input file; terminating"
      return nil
    end
    true
  end

  def analyze
    doc = Nokogiri::XML(open(@file)) { |config| config.noerror }
    @persona = {}
    doc.css('PERSONA').each do |p|
      pname = p.children.text.tr('"','')
      @persona[pname] = 0
    end
    doc.css('SPEAKER').each do |s|
      sname = s.children.text.tr('"','')
      ### Turns out there are speakers without @persona!
      @persona[sname] = 0 if @persona[sname].nil?
      @persona[sname] += 1
    end
  end

  def list_by_speaker_count
    sorted_output = (@persona.sort_by {|k,v| v}).reverse
    sorted_output.each { |a| puts "#{a[1]} #{a[0]}" }
  end
end
