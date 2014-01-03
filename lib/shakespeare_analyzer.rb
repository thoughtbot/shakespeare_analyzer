require_relative 'play'

class ShakespeareAnalyzer
	attr_accessor :play, :speeches, :speakers

	def initialize(play_location)
		@play = Play.new(play_location)
		@speakers = Hash.new(0)
	end

	def lines_per_speaker
		most_verbose_speakers.map { |name, line_count| "#{line_count}\t#{name}\n" }.join
	end

	private
		def most_verbose_speakers
			analyze_speeches
			@speakers.sort_by { |name, line_count| -line_count }
		end

		def get_speeches
			@speeches ||= @play.speeches
		end

		def analyze_speeches
			get_speeches.each do |speech|
				# nested iterators :/
				speech.speakers.each do |speaker|
					# new value is previous value or zero plus the number of lines in the speech
					@speakers[speaker] += speech.lines.count
				end
			end
		end
end
