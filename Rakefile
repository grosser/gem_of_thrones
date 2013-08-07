require "bundler/setup"
require "bundler/gem_tasks"
require "bump/tasks"

task :default do
  system("ps -ef | grep [m]emcached 2>&1 > /dev/null") || raise("Start memcached!")
  sh "rspec spec/"
end
