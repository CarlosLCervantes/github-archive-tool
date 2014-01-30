#<---Pretend these is an Interface here

class OutputReport
	#Include ReportInterface

	def initialize(data, max)
		@data = data
		@max = max
	end

	def print 
		@data.each do |k, v|
			puts "#{k} #{v}"
		end
	end

end

class BetterReport < OutputReport
	def print
		i = 0
		@data.each do |k,v|
			puts "#{k} - #{v} Events"
			break if i > @max
			i = i + 1
		end
	end
end

class ReportType #quick and dirty enum implimentation. There are gems that do this.
	def self.STANDARD() return 0 end
	def self.BETTER() return 1 end
	def self.FANCY() return 2 end
end

class ReportFactory
	#Include ReportInterface
	def self.resolve(data, max, type)
		#pretend there is logic to select a TYPE of report
		return BetterReport.new(data, max)
	end
end