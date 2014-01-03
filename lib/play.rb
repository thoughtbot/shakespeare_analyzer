require 'nokogiri'
require 'open-uri'
require_relative 'speech'

class Play
	attr_accessor :document

	def initialize(play_location)
		@play_location = play_location
	end

	def speeches
		document.css('SPEECH').map do |speech|
			Speech.new speech
		end
	end

	def document
		@document ||= Nokogiri::XML(play_data)
	end

	private
		def play_data
			if location_is_a_file?
				@play_location
			elsif location_is_a_url?
				open(@play_location)
			else
				File.open(@play_location, 'r')
			end
		end

		def location_is_a_file?
			@play_location.is_a? File
		end

		def location_is_a_url?
			@play_location.match(/^http/)
		end
end
