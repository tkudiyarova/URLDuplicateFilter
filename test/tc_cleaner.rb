require_relative "../cleaner"
require "test/unit"

class TestURLDuplicateFilter < Test::Unit::TestCase

	def setup
	   @filter = URLDuplicateFilter.new
	end

	def test_extract_url
		input_line =  ["http://www.wellington.co.nz/home/about",
						"http://www.wellington.co.nz/",
						"wellington.co.nz/home/about",
						"www.wellington.co.nz/home/about/users",
						"	wellington.co.nz	"]
		output_lines = []

		input_line.each do |link|				
			@filter.process(link) { |link| output_lines.push(link) }
		end
		p output_lines
		assert_equal(["http://www.wellington.co.nz/home/about"], output_lines)

	end
end