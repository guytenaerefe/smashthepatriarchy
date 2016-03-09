#!/usr/bin/env ruby
require 'twitter'
require 'yaml'

class Matriarch

    def initialize(config, client)
        @config = config
        @client = client
    end

    # Debugging
    def test_done
        puts check_done('707682618209341440z')
    end

    # Append ID to file 
    def update_done(id)
        open('tweets.done', 'a') { |f|
          f.puts(id)
        }
    end

    # Check 
    def check_done(id)
        return false unless        
            File.foreach('tweets.done') do |line|
                return true if line.chomp == id.to_s
            end
    end

    def watch
        counter = 0
        loop do
            tweet = @client.search("businesswoman").first
            update_done(tweet.id)
            #rand_time = rand(120*60..240*60)
            rand_time = rand(10..300)
            puts tweet.text
            puts 'Tweeted, now resting for a while'
            sleep rand_time
        end
    end

end

config = YAML.load_file('config.yml')
client = client = Twitter::REST::Client.new(config['twitter_credentials'])

spill_it = Matriarch.new(config, client)
spill_it.test_done