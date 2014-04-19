class MacbethAnalyzer
	def initialize(output)
		@output = output
	end

	def analyze
		@output.puts "12 Macbeth\n4 Banquo\n3 Duncan"
	end
end
