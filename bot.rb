#!/usr/bin/env ruby
class Matriarch

    def initialize(config, client)
        @config = config
        @client = client
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
            if !check_done(tweet.id)
                update_done(tweet.id) 
                rand_time = rand(10..300)
                puts tweet.text
                puts 'Tweeted, now resting for a while'
                sleep rand_time
            else 
                puts 'Done this tweet already, let\'s try another'
            end
        end
    end

end