class Speech
  def initialize(speech)
    @speech = speech
  end
  
  def speaker
    @speech.css("SPEAKER").text
  end
  
  def lines
    @speech.css("LINE").count
  end
end