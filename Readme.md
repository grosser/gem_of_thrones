Everybody wants to be king, but only one can win (synchronized via a distributed cache).<br/>
Update something everybody depends on without doing it multiple times or using a cron.

Install
=======
    sudo gem install game_of_thrones
Or

    rails plugin install git://github.com/grosser/game_of_thrones.git


Usage
=====

    aspirant = GameOfThrones.new(
      :cache => Rails.cache, # where to store the lock ?
      :timeout => 60 # if current king does not react the next aspirant will take its place
    )

    Thread.new do
      loop do
        # if there is no king or the old king did not do anything, this yields
        if aspirant.rise_to_power
          # do something that should only be done by one
        end
        sleep 30 # use a timeout lower then the throne timeout
      end
    end

Author
======
[Zendesk](http://zendesk.com)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://secure.travis-ci.org/grosser/game_of_thrones.png)](http://travis-ci.org/grosser/game_of_thrones)
