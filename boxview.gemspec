Gem::Specification.new do |s|
  s.name        = 'boxview'
  s.version     = '0.0.9'
  s.date        = '2014-05-19'
  s.summary     = "Wrapper for box view api"
  s.description = "Wrapper for box view api"
  s.authors     = ["Cyrus Karbassiyoon"]
  s.email       = 'cyrus@cycleio.com'
  s.files       = ["lib/boxview.rb"]
  s.add_development_dependency "faraday"
  s.add_development_dependency "faraday_middleware"
end
