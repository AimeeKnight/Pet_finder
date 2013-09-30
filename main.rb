require 'rubygems'
require 'json'
require 'net/http'
require 'yaml'
require 'sinatra'
require 'sinatra/flash'
require './env' if File.exists?('env.rb')

get '/' do    
    erb :index  
end  

post '/' do
	zip 			= params[:zip].to_s
	key				= ENV['key']
	# CONFIG 		= YAML.load_file("config.yml")
	# key 	 		= CONFIG['petsearch']['key']
	url		 		= "http://api.petfinder.com/pet.find?key=#{key}&format=json&location=#{zip}"
	resp   		= Net::HTTP.get_response(URI.parse(url))
	resp_text = resp.body
	obj 			= JSON.parse(resp_text)
	@pets     = obj["petfinder"]["pets"]["pet"]
	erb :index
end