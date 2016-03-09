#!/usr/bin/env ruby
require 'yaml'
require 'twitter'
require './bot'

config = YAML.load_file('config.yml')
client = client = Twitter::REST::Client.new(config['twitter_credentials'])

spill_it = Matriarch.new(config, client)
spill_it.watch