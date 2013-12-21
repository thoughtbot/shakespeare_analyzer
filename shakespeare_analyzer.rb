require 'open-uri'
require 'nokogiri'
class ShakespeareAnalyzer
  attr_accessor :xml
  def initialize(doc)
    @doc = doc
  end
  
  def analyze
    result = {}
    play = @doc.css("PLAY")
    acts = play.css("ACT")
    acts.each do |act|
      scenes = act.css("SCENE")
      scenes.each do |scene|
        speeches = scene.css("SPEECH")
        speeches.each do |speech|
          speaker = speech.css("SPEAKER").text
          lines = speech.css("LINE").count
          if result[speaker].nil?
             result[speaker] = lines
          else
            result[speaker] = (result[speaker] + lines)
          end
        end
      end
    end
    result
  end
end