Gem::Specification.new do |spec|
  spec.name        = 'slideshare'
  spec.version     = '0.0.0'
  spec.date        = '2016-06-08'
  spec.summary     = 'Slideshare!'
  spec.description = 'A gem for slideshare'
  spec.authors     = ['Juliat Joy']
  spec.email       = 'juliatjoy@gmail.com'
  spec.files       = ['lib/slideshare.rb', 'lib/base.rb']
  spec.homepage    = 'http://rubygems.org/gems/slideshare'
  spec.license     = 'MIT'

  spec.add_dependency 'faraday', '~> 0'
  spec.add_dependency 'faraday_middleware', '~> 0'
  spec.add_dependency 'nokogiri', '~> 1.6'
end
