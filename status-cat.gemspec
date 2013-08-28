$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'status_cat/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'status-cat'
  s.version     = StatusCat::VERSION
  s.authors     = ['Rich Humphrey']
  s.email       = ['rich@schrodingersbox.com']
  s.homepage    = 'https://github.com/schrodingersbox/status-cat'
  s.summary     = 'Rails engine for checking system health'
  s.description = ''

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~>4.0.0'
  # s.add_dependency "jquery-rails"

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails', '~>2.11.0'
  s.add_development_dependency 'webrat', '~>0.7.3'
end
