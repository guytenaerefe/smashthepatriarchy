#!/usr/bin/env ruby

# Word from key/value. TODO: Find out if this is not ass-backward
class Word 
    attr_reader :bad, :good
    def initialize (bad, good)
        @bad = bad
        @good = good
    end
end

class Matriarch

    # I get the creeping feeling I am rubbing ruby the wrong way
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

    # Read random word and put it in a Word
    def random_word
        wordpair = nil
        File.foreach("wordlist").each_with_index do |line, number|
            wordpair = line if rand < 1.0/(number+1)
        end
        word = Word.new(wordpair.split(':')[0], wordpair.split(':')[1])
        return word
    end

    def random_line(name, bad, good)
        reply_line = nil
        File.foreach("linelist").each_with_index do |line,number|
            reply_line = line if rand < 1.0/(number+1)
        end
        reply_line = reply_line.gsub('$GOOD', good.chomp)
        reply_line = reply_line.gsub('$BAD', bad.chomp)
        reply_line = reply_line.gsub('$NAME', name.chomp)
        return reply_line.chomp
    end

    # Main loop
    def watch
        counter = 0
        loop do
            word = random_word
            tweet = @client.search(word.bad + ' -rt', lang: "en").first
            if !check_done(tweet.id) && counter < 50 && tweet.user.screen_name != 'don_quibot'
                reply = random_line(tweet.user.screen_name, word.bad, word.good)
                counter += 1
                update_done(tweet.id) 
                @client.update(reply, in_reply_to_status_id: tweet.id)
                puts tweet.text
                puts reply
                rand_time = rand(180..900)
                time = Time.new
                puts '--- Tweeted, now resting for a while (' + (rand_time/60).to_s + 'm at ' + time.inspect + ') ---'
                sleep rand_time
            elsif counter > 50 
                counter = 0
                rand_time = rand(1800..3600)
                time = Time.new                
                puts '--- Done a shitload of tweets, let\'s try another in a while (' + (rand_time/60).to_s + 'm at ' + time.inspect + ') ---'                
                sleep rand_time
            else 
                rand_time = rand(180..360)
                time = Time.new
                puts '--- Done this tweet (' + tweet.text + ') already, let\'s try another in a while (' + (rand_time/60).to_s + 'm at ' + time.inspect + ') ----'                
                sleep rand_time
            end
        end
    end

end
