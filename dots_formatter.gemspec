Gem::Specification.new do |s|
  s.name        = 'dots_formatter'
  s.version     = '0.0.3'
  s.date        = '2015-09-09'
  s.summary     = "A simple, informative RSpec formatter"
  s.description = "Get instance feedback on number of passed:failed:pending / total with quick failure status"
  s.authors     = ["Paul Brennan"]
  s.email       = 'paul@dryule.com'
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.homepage    =  'https://github.com/yule/dots_formatter'
  s.license     = 'MIT'
end
