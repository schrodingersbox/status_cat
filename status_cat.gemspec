$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'status_cat/version'

Gem::Specification.new do |s|
  s.name        = 'status_cat'
  s.version     = StatusCat::VERSION
  s.date        = '2017-07-22'
  s.licenses    = ['MIT']
  s.authors     = ['Rich Humphrey']
  s.email       = ['rich@schrodingersbox.com']
  s.homepage    = 'https://github.com/schrodingersbox/status_cat'
  s.summary     = 'A Rails engine for checking system health'
  s.description = <<-EOD
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

  s.add_dependency 'rails', '~> 5.0', '>= 5.0.0'

  s.add_development_dependency 'coveralls', '~> 0'
  s.add_development_dependency 'rails-controller-testing', '~> 0'
  s.add_development_dependency 'rspec-rails', '~> 0'
  s.add_development_dependency 'simplecov', '~> 0'
  s.add_development_dependency 'spec_cat', '~> 0'
  s.add_development_dependency 'sqlite3', '~> 0'
  s.add_development_dependency 'term-ansicolor', '~> 0'
  s.add_development_dependency 'webrat', '~> 0'

  s.add_development_dependency 'aws-sdk', '~> 0'
  s.add_development_dependency 'delayed_job_active_record', '~> 0'
  s.add_development_dependency 'fitgem', '~> 0'
  s.add_development_dependency 'httparty', '~> 0'
  s.add_development_dependency 'ruby-sendhub', '~> 0'
  s.add_development_dependency 'stripe', '~> 0'
  s.add_development_dependency 'twilio-ruby', '~> 0'
end
