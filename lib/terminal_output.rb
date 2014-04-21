class TerminalOutput
	def initialize
		@buffer = StringIO.new
	end

	def add_new_line(text)
		@buffer.puts text
	end

	def print
		@buffer.seek(0)
		@buffer.read.chomp
	end
end
