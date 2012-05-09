$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
name = "gem_of_thrones"
require "#{name}/version"

Gem::Specification.new name, GemOfThrones::VERSION do |s|
  s.summary = "Everybody wants to be king, but only one can win (synchronized via a distributed cache)"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = 'MIT'
end
