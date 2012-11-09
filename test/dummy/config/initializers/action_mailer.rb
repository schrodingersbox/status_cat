if Rails.env.test?
  ActionMailer::Base.delivery_method = :test
else
  yaml = YAML::load( IO.read( File.join( Rails.root, 'config', 'passwords.yml' ) ) )
  passwords = HashWithIndifferentAccess.new( yaml[ Rails.env ] )

  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings  = {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'schrodingersbox.com',
    :authentication => :plain,
    :user_name => passwords[ :sendgrid ][ :user_name ],
    :password => passwords[ :sendgrid ][ :password ]
  }
end