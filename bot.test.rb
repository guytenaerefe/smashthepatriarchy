#!/usr/bin/env ruby
require 'test/unit'
require 'twitter'
require 'yaml'
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
end
