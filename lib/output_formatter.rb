class OutputFormatter
	def initialize(output)
		@output = output
	end

	def print_values_descending(hash)	# sort it so that they are in descending order by key (line count)
		sorted_hash = Hash[hash.sort_by { |key, value| value }.reverse]

		sorted_hash.each do |key, value|
			@output.add_new_line "#{value} #{key.capitalize}"
		end
	end
end
