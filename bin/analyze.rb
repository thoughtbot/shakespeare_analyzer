#!/usr/bin/env ruby

require_relative '../lib/shakespeare_analyzer'
require_relative '../lib/downloader'

downloader = Downloader.new file: "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
shakes = ShakespeareAnalyzer.new xml_provider: downloader
shakes.print_lines
