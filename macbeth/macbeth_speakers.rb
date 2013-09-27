## PRESENTATION
require "open-uri"

def print_line(n=20)
  n.times do
    print "-"
    sleep(1.0/24.0)
  end
end

def slow_word(word = "Welcome to Macbeth Speaker Counter")
  word.split("").each do |x|
    print x
    sleep(1.0/24.0)
  end
end
## END PRESENTATION

def xml_source_to_file(get_url = "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
  puts "I'm going to use the file found at:"
  puts get_url
  xml = get_url unless xml
  content = open(xml) {|f| f.read }
  xml_destination = 'macbeth.xml'
  File.open(xml_destination, 'w+') do |f|
    f.write content
    f.close
  end
end

def clean_array_items(array)
  array.map do |x|
    x.gsub!("<SPEAKER>", "")
    x.gsub!("</SPEAKER>", "")
    x.gsub!("\n", "")
  end
end

def list_speakers
  # create speakers array
  speakers = []
  #open file for reading
  File.open('macbeth.xml', 'r').each do |line|
      speakers << line if line =~ /<SPEAKER>/
  end
  #puts speakers.size
  speakers = clean_array_items(speakers)
end

def counts(speakers)
  counts = Hash.new(0)
  speakers.each { |speaker| counts[speaker] += 1 }
  counts = counts.sort_by { |key, value| value.to_i }.reverse
  counts.each {|key, value| puts "#{value.to_i} #{key.upcase}" }
end

print_line 10
slow_word
print_line 10
puts

xml_source_to_file
print_line 60
puts
counts(list_speakers)