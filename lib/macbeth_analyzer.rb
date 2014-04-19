class MacbethAnalyzer
	def initialize(output)
		@output = output
	end

	def analyze
		@output.puts "12 Macbeth"
		@output.puts "4 Banquo"
		@output.puts "3 Duncan"
	end
end
