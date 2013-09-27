#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'net/http'


url = "http://api.petfinder.com/pet.find?key=2f8910923ead50b256537ffc4893787b&format=json&location=31324"

resp = Net::HTTP.get_response(URI.parse(url))

resp_text = resp.body
obj = JSON.parse(resp_text)

obj["petfinder"]["pets"]["pet"].each do |num| 
	puts num["name"]["$t"]
	puts num["animal"]["$t"]
	puts num["sex"]["$t"]
	puts num["age"]["$t"]
	puts num["media"]["photos"]["photo"][0]["$t"]
	puts num["contact"]["phone"]["$t"]
end

