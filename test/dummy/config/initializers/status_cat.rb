StatusCat.configure do |config|

  config.email_to = 'rich@schrodingersbox.com'
  config.email_from = 'noreply@schrodingersbox.com'
  config.email_subject = "#{Rails.env.upcase} StatusCat Failure"

end