#!/usr/bin/env ruby

require_relative '../lib/shakespeare_analyzer.rb'

DEFAULT_XML_URL = 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml'

analyzer = ShakespeareAnalyzer.new(DEFAULT_XML_URL)
analyzer.run
