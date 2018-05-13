$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'system_cat/version'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'status_cat'
  s.version     = SystemCat::Version.new.to_s
  s.date        = Date.today.to_s
  s.licenses    = ['MIT']
  s.authors     = ['Rich Humphrey']
  s.email       = ['rich@schrodingersbox.com']
  s.homepage    = 'https://github.com/schrodingersbox/status_cat'
  s.summary     = 'A Rails engine for checking system health'
  s.description = <<-DESCRIPTION
    This engine makes monitoring the status of your Rails environment easier.

    It provides a Rails action with a green light / red light list of configured services,
    such as:

     * ActionMailer
     * ActiveRecord
     * AWS S3
     * Delayed Job
     * Stripe
  DESCRIPTION

  s.files = Dir['{app,config,db,lib,spec/support/shared}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.0', '>= 5.0.0'
  s.add_dependency 'require_all'

  s.add_development_dependency 'coveralls'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'spec_cat'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'term-ansicolor'

  s.add_development_dependency 'aws-sdk'
  s.add_development_dependency 'delayed_job_active_record'
  s.add_development_dependency 'fitgem'
  s.add_development_dependency 'httparty'
  s.add_development_dependency 'ruby-sendhub'
  s.add_development_dependency 'slack-ruby-client'
  s.add_development_dependency 'stripe'
  s.add_development_dependency 'twilio-ruby'
end
