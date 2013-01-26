Everybody wants to be king, but only one can win (synchronized via a distributed cache).<br/>
Update something everybody depends on without doing it multiple times or using a cron.

Cache must support the interface `write(key, value, :expires_in => xxx, :unless_exist => true)`,<br/>
which afaik only `ActiveSupport::Cache::MemCacheStore`, [ActiveSupport::Cache::LibmemcachedStore](https://github.com/benhutton/libmemcached_store) and `ActiveSupport::Cache::MemoryStore` @ rails edge do.


Install
=======

    gem install gem_of_thrones

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

When not to use (by [Ben Osheroff](https://github.com/osheroff))
==================
For a really critical master, memcache isn't traditionally that great.
Memcache's best high-availability offering is a cluster of servers with the key hashing to a different server,
and a server can drop out (due to timeouts or sporadic failures or what have you),
and then you lose cache coherency and some servers can think a key belongs somewhere
and some servers think it belongs elsewhere, and it's just not that great.
What you're left with then is either going with a single memcache (single point of failure, oy),
or sacrificing true locks.

Redis might be slightly better solution as it at least offers some failover via replication, and I think it has a check-and-set operator.

The big heavies in this space are of course zookeeper etc, but that can be overboard.

Author
======
[Zendesk](http://zendesk.com)<br/>
michael@grosser.it<br/>
License: MIT<br/>
[![Build Status](https://travis-ci.org/grosser/gem_of_thrones.png)](https://travis-ci.org/grosser/gem_of_thrones)
