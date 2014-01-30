# Demo uses ruby-1.9.3

# Required 3rd party gems 
#########################
# yajl-ruby gem 

# Sample Input
#########################
#ruby gh_repo_stats.rb --after 2012-11-01T13:00:00Z --before 2012-11-02T03:12:14-03:00 --event PushEvent --count 42

# Output
#########################
# Outputs Top (n) most popular Github repositories for the given time span

require 'open-uri'
require 'zlib'
require 'yajl'
require 'active_support/all'
require 'optparse'
require_relative 'config.rb'
require_relative 'options.rb'
require_relative 'date_time_helper.rb'
require_relative 'event_type.rb'
require_relative 'report.rb'

def get_json url
	# Could cache downloaded gzip files in local filesystem.
	# This would reduce resources associated with constant use.
	# For demo, just pull from service everytime.
	gz = open(url)
	Zlib::GzipReader.new(gz).read
end

# Validate Inputs
options = get_options
check_option options, :after
check_option options, :before
unless is_valid_event options[:event]
	puts "Event Type is Invalid"
	exit 1
end
max_records = (options[:count] || CONFIG[:DEFAULT_RECORD_COUNT]).to_i

#Calculate Time Difference
after = DateTime.parse(options[:after]) #Could add date format check
before = DateTime.parse(options[:before]) #Could add date format check
timespan_validation_result = is_timespan_valid after, before
unless timespan_validation_result[:valid]
	puts timespan_validation_result[:msg]
	exit 1
end
hours_diff = ((before.to_time - after.to_time) / 60 / 60).to_i

# Iterate through hours in timespan. Ideally there would be a bulk option for the service. 
# But there isn't one that doesn't result in multiple requests anyways.
current = after - 1.hours
results = {}
puts "Getting data"
for h in 1..hours_diff
	current  = current + 1.hours
	file_name = get_file_time current
	# Sample format http://data.githubarchive.org/2012-11-01-01.json.gz
	json = get_json "http://data.githubarchive.org/#{file_name}.json.gz"
	Yajl::Parser.parse(json) do |event|
		if event["type"] == options[:event]
			owner = event["repository"]["owner"]
			repo_name = event["repository"]["name"]
			key = "#{owner}/#{repo_name}"
			results[key] = (results[key] || 0) + 1
		end
	end
	print ((h.to_f / hours_diff.to_f) * 100).to_i.to_s + "% "
end

#Display results
results = results.sort_by { |k, v| v }.reverse
report = ReportFactory.resolve(results, max_records, ReportType.BETTER)
report.print