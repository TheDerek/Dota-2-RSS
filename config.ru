require 'rubygems'
require 'sinatra'
require 'bundler'
Bundler.require(:default)
require File.expand_path '../app.rb', __FILE__

run Sinatra::Application
