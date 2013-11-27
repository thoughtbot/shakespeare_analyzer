require_relative 'play'

class ShakespeareAnalyzer
	attr_accessor :play, :speeches, :speakers

	def initialize(play_location)
		@play = Play.new(play_location)
		analyze_speeches
	end

	def print_lines_per_speaker!
		most_verbose_speakers.each do |name, line_count|
			puts "#{line_count}\t#{name}"
		end
	end

	private
		def most_verbose_speakers
			@speakers.sort_by { |name, line_count| -line_count }
		end

		def get_speeches
			@speeches ||= @play.speeches
		end

		def analyze_speeches
			@speakers ||= {}
			get_speeches.each do |speech|
				# nested iterators :/
				speech.speakers.each do |speaker|
					# new value is previous value or zero plus the number of lines in the speech
					@speakers[speaker] = ( @speakers[speaker] || 0 ) + speech.lines.count
				end
			end
		end
end
