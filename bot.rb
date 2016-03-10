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
        reply_line = reply_line.gsub('$GOOD', good)
        reply_line = reply_line.gsub('$BAD', bad)
        reply_line = reply_line.gsub('$NAME', name)
        return reply_line
    end

    # Main loop
    def watch
        counter = 0
        loop do
            word = random_word
            tweet = @client.search(word.bad).first
            #line = random_line()
            if !check_done(tweet.id) || counter > 50
                reply = random_line(tweet.user.screen_name, word.bad, word.good)
                # SEND TWEET HERE. HOLD ON TO YOUR HORSES
                counter += 1
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
