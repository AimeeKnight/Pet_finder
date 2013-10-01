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
	zip 			= params[:zip]
	if valid_zip zip
		key				= ENV['key']
		url		 		= "http://api.petfinder.com/pet.find?key=#{key}&format=json&location=#{zip}"
		resp   		= Net::HTTP.get_response(URI.parse(url))
		resp_text = resp.body
		obj 			= JSON.parse(resp_text)
		@pets     = obj["petfinder"]["pets"]["pet"]
		erb :index
	else
		flash.now[:error] = "Please enter a 5 digit zip code."
		erb :index
	end
end

def valid_zip zip
	zip.length == 5 && zip =~ /^\d+$/
end