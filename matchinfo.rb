require 'bundler/setup'
require 'dota'
require 'pp'
require 'whenever'
require 'rss'

class Dota::LiveLeague
	def ==(match2)
		self.lobby_id == match2.lobby_id
	end

	alias :eql? :==

	def hash
		self.lobby_id.hash
	end

	def to_s
		"#{self.lobby_id} -  #{self.radiant.name} vs #{self.dire.name}"
	end

	def display_string
		"#{self.radiant.name} vs #{self.dire.name}"
	end

	def get_start_time
		#Avoid unesseary API calls, start time will always be the same
		unless @start_time
			@start_time = Dota.match(self.lobby_id).start
		end
		@start_time
	end

end

def print_matches(matches)
	matches.each do |match|
		puts match
	end
end

# Prepare the API key
Dota.configure do |config|
	config.api_key = 'YOUR KEY HERE'
end

# Return an array of live league games sorted by date (newest first)
def get_live_league_games
	current_matches = []
	Dota.live_leagues.each do |match|
		if match.raw_live_league['dire_team'] && match.raw_live_league['radiant_team']
			current_matches.push(match)

		end
	end

	#puts 'New Matches:'
	current_matches.sort! { |a, b| b.lobby_id <=> a.lobby_id }
	current_matches
end

#get_live_league_games
