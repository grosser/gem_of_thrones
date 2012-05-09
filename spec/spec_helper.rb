$LOAD_PATH.unshift 'lib'
require 'game_of_thrones'

require 'memcached'
require 'active_support/cache'
require 'active_support/cache/libmemcached_store'

# needed by ActiveSupport::Cache::Store
class String
  def duplicable?
    true
  end
end
