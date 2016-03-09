#!/usr/bin/env ruby
require 'twitter'
require 'yaml'

config = YAML.load_file('config.yml')

client = Twitter::REST::Client.new(config['twitter_credentials'])

test = client.search("businesswoman").first.text
puts test
