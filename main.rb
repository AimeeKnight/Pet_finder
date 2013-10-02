require 'rubygems'
require 'json'
require 'net/http'
require 'sinatra'
require 'sinatra/flash'
require './env' if File.exists?('env.rb')
enable :sessions

get '/' do    
    erb :index  
end  

post '/' do
	@zip = params[:zip]
	@key = ENV['key']
	@url	= "http://api.petfinder.com/pet.find?key=#{@key}&format=json&location=#{@zip}"
	@resp	= Net::HTTP.get_response(URI.parse(@url))
	@resp_text = @resp.body
	@obj = JSON.parse(@resp_text)

	if valid_zip @zip
		@pets = @obj["petfinder"]["pets"]["pet"]
	else
		flash.now[:error] = "Please enter a valid 5 digit zip code."
	end
	erb :index
end

def valid_zip zip
	zip =~ /^\d{5}$/ && @obj["petfinder"]["header"]["status"]["message"]["$t"] != "invalid_location"
end