class MacbethAnalyzer
	def initialize()
		@output = TerminalOutput.new
	end

	def analyze
		@output.add_new_line "12 Macbeth"
		@output.add_new_line "4 Banquo"
		@output.add_new_line "3 Duncan"

		@output.print
	end
end
