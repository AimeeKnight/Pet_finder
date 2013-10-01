require 'rubygems'
require 'bundler'
require 'rspec'
require 'rack/test'
require_relative '../main.rb'

set :environment, :test

def app
	Sinatra::Application
end

describe "Index page" do
	include Rack::Test::Methods

	it "should load the home page" do
		get '/'
		last_response.should be_ok
	end
end

describe "valid_zip" do
	it "returns true with a valid zip code" do
		valid_zip("12345").should be_true
	end

	it "returns nil with an invalid zip code" do
		valid_zip("hi").should be_nil
	end
end