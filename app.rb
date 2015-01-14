require 'bundler/setup'
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'builder'
require 'data_mapper'
require './matchinfo'

get '/' do
	'hello world'
end

get '/dota' do
	@matches = get_live_league_games
	builder :rss
end

