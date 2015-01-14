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
		"#{self.lobby_id} - #{self.radiant.name} vs #{self.dire.name}"
	end

	def display_string
		"#{self.radiant.name} vs #{self.dire.name}"
	end

end

def print_matches(matches)
	matches.each do |match|
		puts match
	end
end

# Pushes information via rss about a dota2 match
def push(match, rss)
	puts rss
end

# Array to hold the old matches
@old_matches = []

# Rss feed information
@rss = RSS::Maker.make('atom') do |maker|
	maker.channel.author = 'Derek'
	maker.channel.updated = Time.now.to_s
	maker.channel.about = 'http://derek.ml'
	maker.channel.title = 'Dota 2 League Matches Notifications'
end

# Prepare the API key
Dota.configure do |config|
	config.api_key = '7AE87E5EA003D86CEA6843289DB48B53'
end


while true do
	# Collect current matches
	current_matches = []
	Dota.live_leagues.each do |match|
		if match.raw_live_league['dire_team'] && match.raw_live_league['radiant_team']
			current_matches.push(match)
		end
	end

	# Compare current matches to old matches, collect the new
	# matches that appear by getting the relative component of
	# @old_matches in current_matches
	new_matches = current_matches - @old_matches

	unless new_matches.empty?
		#puts 'New Matches:'
		print_matches new_matches
		new_matches.each{ |x| push(x, @rss) }
	end

	# Set the old matches to the ones we just parsed
	@old_matches = current_matches

	# Wait for another minute or two
	sleep 60
end

