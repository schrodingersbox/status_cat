# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start 'rails' do
  add_filter '/vendor/'
  add_filter '/spec/'
end

require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'

require 'spec_cat'

require 'fitgem'
require 'httparty'
require 'ruby-sendhub'
require 'twilio-ruby'

ENGINE_ROOT = File.join(File.dirname(__FILE__), '..')

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_ROOT, "spec/support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before( :each ) do
    allow( Fitgem::Client ).to receive( :new ).and_return( @fitgem = double( Fitgem::Client ) )
    allow( @fitgem ).to receive( :user_info ).and_return( {} )

    allow( HTTParty ).to receive( :get ).and_return( double( "response", :code => 200 ) )

    allow( SendHub ).to receive( :new ).and_return( @send_hub = double( SendHub ) )
    allow( @send_hub ).to receive( :get_contacts ).and_return( {} )

    allow( Twilio::REST::Client ).to receive( :new ).and_return( @twilio = double( Twilio::REST::Client ) )
    allow( @twilio ).to receive( :account ).and_return( @twilio_account = double( Twilio::REST::Account ) )
    allow( @twilio_account ).to receive( :messages ).and_return( @twilio_messages = double( Twilio::REST::Messages ) )
    allow( @twilio_messages ).to receive( :total ).and_return( 0 )
  end
end
