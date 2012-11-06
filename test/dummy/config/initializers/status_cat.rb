StatusCat.configure do |config|

  config.to = 'rich@schrodingersbox.com'
  config.from = 'noreply@schrodingersbox.com'
  config.subject = "#{Rails.env.upcase} StatusCat Failure"

end