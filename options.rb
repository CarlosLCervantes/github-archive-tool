def get_options
	options = {}

	opt_parser = OptionParser.new do |opt|
	  #opt.banner = "Usage: gh_repo_stats [OPTIONS]"
	  #opt.separator  "Options"

	  opt.on("-a arg", "--after arg","Start time for lookup") do |after|
	    options[:after] = after
	  end

	  opt.on("-b arg","--before arg","End time for lookup") do |before|
	    options[:before] = before
	  end

	  opt.on("-e arg","--event arg","The type of event to look for") do |event|
	    options[:event] = event
	  end

	  opt.on("-c arg","--count arg","The number of rows to return. Default #{CONFIG[:DEFAULT_RECORD_COUNT]}.") do |count|
	    options[:count] = count
	  end

	  opt.on("--help","help") do
	    puts opt_parser
	  end
	end

	opt_parser.parse!
	return options
end

def check_option options, key
	if options[key].blank?
		puts "Please enter a valid date for --#{key}"
	end
end

