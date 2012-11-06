if Rails.env.test?
  ActionMailer::Base.delivery_method = :test
else
  yaml = YAML::load( ERB.new( IO.read( File.join( Rails.root, 'config', 'passwords.yml' ) ) ).result )
  passwords = HashWithIndifferentAccess.new( yaml[ Rails.env ] )

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings  = {
    :address => 'smtp.sendgrid.net',
    :port => '25',
    :domain => 'schrodingersbox.com',
    :authentication => :plain,
    :user_name => passwords[ :sendgrid ][ :username ],
    :password => passwords[ :sendgrid ][ :password ]
  }
end