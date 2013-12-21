require_relative 'speech'
class ShakespeareAnalyzer
  attr_accessor :doc,:result
  def initialize(doc)
    @doc = doc
    @result = {}
  end
  
  def analyze
    play = get_play
    acts = get_acts_from_play(play)
    acts.each do |act|
      add_act_to_result(act)
    end
  end
  
  def add_act_to_result(act)
    scenes = act.css("SCENE")
    scenes.each do |scene|
      add_scene_to_result(scene)
    end
  end
  
  def add_scene_to_result(scene)
    speeches = get_speeches_from_scene(scene)
    speeches.each do |speech|
      add_speech_to_result(speech)
    end
  end
  
  def get_play
    @doc.css("PLAY")
  end
  
  def get_acts_from_play(play)
    play.css("ACT")
  end
  
  def get_speeches_from_scene(scene)
    scene.css("SPEECH")
  end
  
  def add_speech_to_result(speech)
    speech = Speech.new(speech)
    speaker = speech.speaker
    lines = speech.lines
    add_to_result(speaker,lines)
  end
  
  def add_to_result(speaker,lines)
    if @result[speaker].nil?
       @result[speaker] = lines
    else
      @result[speaker] =  (@result[speaker] + lines)
    end
  end
  
  def print_result
    @result.each do |name,lines|
      puts "#{lines} #{name}"
    end
  end
end