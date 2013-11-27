require 'nokogiri'
require 'open-uri'
require_relative 'speech'

class Play
	attr_accessor :document

	def initialize(play_location)
		unless play_location.is_a? File
			if play_location.match(/^http/)
				play_location = open(play_location)
			else
				play_location = File.open(play_location, 'r')
			end
		end
		@document = Nokogiri::XML(play_location)
	end

	def speeches
		document.css('SPEECH').map do |speech|
			Speech.new speech
		end
	end
end
