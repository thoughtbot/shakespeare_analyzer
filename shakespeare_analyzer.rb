require_relative 'lib/xml_parser'

xml_doc = XmlParser.new("http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml")
xml_doc.parse_speeches
xml_doc.print_result