$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'status_cat/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'status_cat'
  s.version     = StatusCat::VERSION
  s.authors     = ['Rich Humphrey']
  s.email       = ['rich@schrodingersbox.com']
  s.homepage    = 'https://github.com/schrodingersbox/status_cat'
  s.summary     = 'Rails engine for checking system health'
  s.description = ''

  s.files = Dir['{app,config,db,lib,spec/support/shared}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.0', '>= 4.0.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.0'
  s.add_development_dependency 'rspec-rails', '~> 2.14', '>= 2.14.0'
  s.add_development_dependency 'webrat', '~>0.7.3'
end
