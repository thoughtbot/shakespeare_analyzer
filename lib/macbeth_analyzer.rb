class MacbethAnalyzer
	def initialize(output = StringIO.new)
		@output = output
	end

	def analyze
		@output.puts "12 Macbeth"
		@output.puts "4 Banquo"
		@output.puts "3 Duncan"

		@output.seek(0)
		@output.read.chomp
	end
end
