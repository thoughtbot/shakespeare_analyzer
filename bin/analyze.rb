#!/usr/bin/env ruby

require '../lib/shakespeare_analyzer'
require '../lib/downloader'

downloader = Downloader.new file: "http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml"
shakes = ShakespeareAnalyzer.new downloader: downloader
shakes.print_lines
