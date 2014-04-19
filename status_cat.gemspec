$:.push File.expand_path('../lib', __FILE__)

require 'status_cat/version'

Gem::Specification.new do |s|
  s.name        = 'status_cat'
  s.version     = StatusCat::VERSION
  s.licenses    = ['MIT']
  s.authors     = ['Rich Humphrey']
  s.email       = ['rich@schrodingersbox.com']
  s.homepage    = 'https://github.com/schrodingersbox/status_cat'
  s.summary     = 'A Rails engine for checking system health'
  s.description =<<-EOD
    This engine makes monitoring the status of your Rails environment easier.

    It provides a Rails action with a green light / red light list of configured services,
    such as:

     * ActionMailer
     * ActiveRecord
     * AWS S3
     * Delayed Job
     * Stripe
  EOD

  s.files = Dir['{app,config,db,lib,spec/support/shared}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 4.0', '>= 4.0.0'

  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.8'
  s.add_development_dependency 'rspec', '~> 2.14', '>= 2.14.0'
  s.add_development_dependency 'rspec-rails', '~> 2.14', '>= 2.14.0'
  s.add_development_dependency 'webrat', '~> 0.7', '>= 0.7.3'
end
