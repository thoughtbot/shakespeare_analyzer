require_relative 'callback_handler'

handler = CallbackHandler.new
XML::SAX::Parser.new(handler).parse_io(open("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"))
results = handler.results.sort_by {|k,v| v}.reverse
results.each {|k,v| puts "  #{v} #{k.capitalize}" }
