xml.instruct! :xml, :version => '1.0'
xml.rss :version => "2.0" do
	xml.channel do
		xml.title "Liftoff News"
		xml.description "Liftoff to Space Exploration."
		xml.link "http://liftoff.msfc.nasa.gov/"

		@matches.each do |match|
			xml.item do
				xml.title match.display_string
				xml.link "http://www.datdota.com/ticket_live.php?q=#{match.lobby_id}"
				xml.description "Match ID: #{match.lobby_id}"
				#xml.pubDate Time.now.rfc822
				#xml.guid "http://liftoff.msfc.nasa.gov/posts/5"
			end
		end
	end
end