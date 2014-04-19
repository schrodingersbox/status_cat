# schrodingersbox/status_cat README

This engine makes monitoring the status of your Rails environment easier.

It provides a Rails action with a green light / red light list of configured services,
such as:

 * ActionMailer
 * ActiveRecord
 * AWS S3
 * Delayed Job
 * Stripe

## Getting Started

1. Add this to your `Gemfile` and `bundle install`

		gem 'status_cat', :git => 'https://github.com/schrodingersbox/status_cat.git'

2. Add this to your `config/routes.rb`

		mount StatusCat::Engine => '/status_cat'

3. Restart your Rails server

4. Run `rake status_cat:check` for a text status report

5.  Visit http://yourapp/status_cat in a browser for an HTML status report

## Configuration

  All configuration should go in `config/initializers/status_cat.rb`.

      Status.configure do |config|

          config.authenticate_with do
            authenticate!
          end

          config.authorize_with do
            authorize!
          end

          config.layout = 'admin'

          config.noreply = 'noreply@schrodingersbox.com'
          config.to = 'ops@schrodingersbox.com'
          config.from = 'ops@schrodingersbox.com'
          config.subject = "#{Rails.env.upcase} StatusCat Failure"

      end

## How To

### Configure Enabled Checkers

By default, all subclasses of StatusCat::Checkers::Base will be run.  Do the following if you would like to limit or reorder the set of checkers

Create or add to `config/initializers/status_cat.rb`

    StatusCat.configure do |config|
      config.enabled = [ :action_mailer, :active_record ]
    end

### Configure Email Settings

Create or add to `config/initializers/status_cat.rb`

    StatusCat.configure do |config|
      config.noreply = 'noreply@schrodingersbox.com'
      config.to = 'ops@schrodingersbox.com'
      config.from = 'ops@schrodingersbox.com'
      config.subject = "#{Rails.env.upcase} StatusCat Failure"
    end

### Run Status Checks From A Cron

1. Run `rake status_cat:cron` from a cron job or other scheduling system.

PLEASE NOTE: The :action_mailer checker will attempt to send a test email to your `StatusCat.config.noreply` email address.  This could cause unwanted spam or incur charges if you're using a metered mail transfer agent, like SendGrid.

### Add New Checkers

You can place new checkers anywhere you like, but `app/checkers` is the recommended location.

1.  Add the following to `config/application.rb`

    	Dir[Rails.root + 'app/checkers/**/*.rb'].each { |path| require path }

2.  Create a new subclass of `StatusCat::Checkers::Base` that sets `@value` and `@status` instance variables.

	    module StatusCat
	      module Checkers
	        class Dummy < Base
	          def initialize
	            @value = 'dummy'
	            @status = 'fail'
	          end
	        end
	      end
	    end

### Require authentication

Create or add to `config/initializers/status_cat.rb`

    StatusCat.configure do |config|
      config.authenticate_with do
        warden.authenticate! scope: :user
      end
    end

### Require authorization

Create or add to `config/initializers/status_cat.rb`

    StatusCat.configure do |config|
      config.authorize_with do
        redirect_to main_app.root_path unless current_user.try(:admin?)
      end
    end

### Apply a custom layout

Create or add to `config/initializers/status_cat.rb`

    StatusCat.configure do |config|
      config.layout = 'admin'
    end

## Reference

 * [Getting Started with Engines](http://edgeguides.rubyonrails.org/engines.html)
 * [Testing Rails Engines With Rspec](http://whilefalse.net/2012/01/25/testing-rails-engines-rspec/)
 * [How do I write a Rails 3.1 engine controller test in rspec?](http://stackoverflow.com/questions/5200654/how-do-i-write-a-rails-3-1-engine-controller-test-in-rspec)
 * [Best practice for specifying dependencies that cannot be put in gemspec?](https://groups.google.com/forum/?fromgroups=#!topic/ruby-bundler/U7FMRAl3nJE)
 * [Clarifying the Roles of the .gemspec and Gemfile](http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/)
 * [The Semi-Isolated Rails Engine](http://bibwild.wordpress.com/2012/05/10/the-semi-isolated-rails-engine/)
 * [config.reload_plugins = true only works in environment.rb](https://rails.lighthouseapp.com/projects/8994/tickets/2324-configreload_plugins-true-only-works-in-environmentrb?spam=1)
 * [describe vs. context in rspec](http://lmws.net/describe-vs-context-in-rspec)
 * [Add Achievement Badges to Your Gem README](http://elgalu.github.io/2013/add-achievement-badges-to-your-gem-readme/)
 * [Publishing your gem](http://guides.rubygems.org/publishing/)

## History

Version 0.0.2 = Rails 3 compatible
Version 0.0.3 = Rails 4 compatible

## TODO

* Add disk space checker with externally configurable limit
* Add Zencoder checker?
* Add NewRelic checker?

* Dynamically create rake tasks for each checker

* Doc
  * General checker concept
  * Shared spec

* Publish as gem