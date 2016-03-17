#!/usr/bin/env ruby
require 'test/unit'
require 'twitter'
require 'yaml'
require 'erb'
require './bot'

class TC_Bot < Test::Unit::TestCase

    def test_key_already_handled_
        test_it = Matriarch.new({}, {})
        assert(test_it.check_done(707682618209341440), 'Item does exist')

    end

    def test_retrieve_valid_key_value
        test_it = Matriarch.new({}, {})
        word = test_it.random_word
        assert_not_nil(word.bad)
        assert_not_nil(word.good)
    end

    def test_tweet_too_long
        template = ERB.new File.new("config.yml").read
        config = YAML.load template.result(binding)
        #config = YAML.load_file('config.yml')
        client = client = Twitter::REST::Client.new(config['twitter_credentials'])
        test_it = Matriarch.new(config, client)
        assert_raise Twitter::Error::Forbidden do
            test_it.send_tweet('this text surely is way over one hundred and fourty characters do you not think so too? Well not yet, but almost. Wurbleburble wopbankawampa shizluwuzuzuzu. Ok now it is over one hundred fifty.')
        end
    end
end
