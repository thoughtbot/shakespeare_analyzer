def example_play_path
    File.join(File.dirname(__FILE__), 'example_play.xml')
end

def example_play
    File.open(example_play_path, 'r')
end

def nk_example_play
    Nokogiri::XML(example_play)
end
