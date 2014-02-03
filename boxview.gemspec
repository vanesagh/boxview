Gem::Specification.new do |s|
  s.name        = 'boxview'
  s.version     = '0.0.7'
  s.date        = '2013-02-03'
  s.summary     = "Wrapper for box view api"
  s.description = "Wrapper for box view api"
  s.authors     = ["Cyrus Karbassiyoon"]
  s.email       = 'ckarbass@gmail.com'
  s.files       = ["lib/boxview.rb"]
  s.add_development_dependency "faraday"
  s.add_development_dependency "faraday_middleware"
end
