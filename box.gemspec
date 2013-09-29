Gem::Specification.new do |s|
  s.name        = 'box'
  s.version     = '0.0.0'
  s.date        = '2013-09-28'
  s.summary     = "Wrapper for box view api"
  s.description = "Wrapper for box view api"
  s.authors     = ["Cyrus Karbassiyoon"]
  s.email       = 'ckarbass@gmail.com'
  s.files       = ["lib/box/view.rb"]
  s.add_development_dependency "faraday"
  s.add_development_dependency "faraday_middleware"
end
