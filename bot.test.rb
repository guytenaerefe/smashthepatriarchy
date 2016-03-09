require 'test/unit'
require 'twitter'
require 'yaml'
require './bot'

class TC_Bot < Test::Unit::TestCase
    def test_win
        test_it = Matriarch.new({}, {})
        assert(test_it.check_done(707682618209341440), 'Item does exist')
    end
end