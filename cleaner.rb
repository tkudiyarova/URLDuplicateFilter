require "set"

class URLDuplicateFilter

	def initialize
		@set = SortedSet.new();
	end

	def process(line)
		link = extract_url line
		if link
			unless @set.include?(link)
				@set.add(link)
				yield(line)
			end
		else
			yield(line)
		end
	end

	private
	def extract_url line
		pattern = /[a-z\d\-.]+\.[a-z]+/
		match = pattern.match(line)
		if match
			link = match[0].sub(/www./, "")
		end
	end
end



if __FILE__ == $0
	input_fn = ARGV[0]
	filter = URLDuplicateFilter.new
	File.open("#{input_fn}-cleaned", 'w') do | output |
		File.open(input_fn, 'r') do |input|
			input.each_line do |line|
				filter.process(line) {|output_line| output.puts(output_line)}
			end
		end
	end
end



