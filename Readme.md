Everybody wants to be king, but only one can win (synchronized via a distributed cache).<br/>
Update something everybody depends on without doing it multiple times or using a cron.

Cache must support the interface `write(key, value, :expires_in => xxx, :unless_exist => true)`,<br/>
which afaik only `ActiveSupport::Cache::MemCacheStore` and [ActiveSupport::Cache::LibmemcachedStore](https://github.com/benhutton/libmemcached_store) do.


Install
=======
    gem install gem_of_thrones
Or

    rails plugin install git://github.com/grosser/gem_of_thrones.git


Usage
=====

    aspirant = GemOfThrones.new(
      :cache => Rails.cache, # where to store the lock ?
      :timeout => 60 # if current king does not react the next aspirant will take its place
    )

    Thread.new do
      loop do
        # if I can be king (there is no king or the old king did not do anything)
        if aspirant.rise_to_power
          # do something that should only be done by one
        end
        sleep 30 # if you choose a timeout greater then the throne timeout the king will always change
      end
    end

Author
======
[Zendesk](http://zendesk.com)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://secure.travis-ci.org/grosser/gem_of_thrones.png)](http://travis-ci.org/grosser/gem_of_thrones)
