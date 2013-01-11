require "set"


def clean_file file_name
	clean_file = File.new("#{file_name}-cleaned", File::CREAT|File::TRUNC|File::RDWR, 0644)
	set = SortedSet.new();
	f = File.open(file_name, 'r') 
	while (line = f.gets)
		link = regex line
		if link
			unless set.include?(link)
				set.add(link)
				clean_file.puts(line)
			end
		else
			clean_file.puts(line)
		end
	end
	unless clean_file.closed? || f.closed?
		puts "input and input-cleaned file will be closed"	
		clean_file.close
		f.close
	end
end

def regex link
	pattern = /[a-z\d\-.]+\.[a-z]+/
	match = pattern.match(link)
	if match
		link = match[0].sub(/www./, "")
	end
end

clean_file ARGV[0]
