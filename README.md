# Smash the Patriarchy! [![Build Status](https://travis-ci.org/guytenaerefe/smashthepatriarchy.svg?branch=master)](https://travis-ci.org/guytenaerefe/smashthepatriarchy)

Raising awareness about genderbiased words in everyday life while learning a thing or two about ruby. Find it on [twitter](https://twitter.com/don_quibot)

* `$ bundle install`
* `$ cp config.yml.example config.yml` (and fill it with your app credentials)

## Contact
If you see this insane bad code and you are pulling your hair, crying to yourself, hoping [Why](https://en.wikipedia.org/wiki/Why_the_lucky_stiff) will never read this, please
feel free to strike down with righteous education. Only do this if you are not heavily invested in the tissuemarket, or
if you're a stockbroker for said market and know what you are doing.

This bot was inspired by my dear pal Aengus Walton's [grammer_man](https://github.com/kopf/grammer_man), which was written in python. 

## Run test
Run the single puny test with `rake`. Oh it will fail! (_hint:_ `echo "707682618209341440" > tweets.done`)
For running on Travis-CI, please enter your Twitter app credentials as environment variables. In the travis build
the `config.travis.yml` will be copied to `config.yml`, so it will work locally as well as on travis.

## Todo
* Add moar random sentences
* Remove some false-positive sensitive words (like waitress) 

