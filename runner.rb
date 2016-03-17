#!/usr/bin/env ruby
require 'yaml'
require 'twitter'
require 'optparse'
require './bot'

# Cool stuff:
# http://ruby-doc.org/stdlib-2.3.0/libdoc/optparse/rdoc/OptionParser.html
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: runner.rb [options]"
  opts.on('-n', '--dry-run', 'Dry Run: Don\'t actually tweet it') { |v| options[:dryrun] = v }
end.parse!

config = YAML.load_file('config.yml')
client = client = Twitter::REST::Client.new(config['twitter_credentials'])

spill_it = Matriarch.new(config, client, options)
spill_it.watch

