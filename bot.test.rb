require 'test/unit'
require 'twitter'
require 'yaml'
require './bot'

class TC_Bot < Test::Unit::TestCase
    def test_win
        config = YAML.load_file('config.yml')
        client = client = Twitter::REST::Client.new(config['twitter_credentials'])        
        test_it = Matriarch.new(config, client)
        assert(test_it.check_done(707682618209341440), 'Item does exist')
    end
end