StatusCat.configure do |config|

  config.noreply = 'noreply@schrodingersbox.com'
  config.to = 'rich@schrodingersbox.com'
  config.from = 'noreply@schrodingersbox.com'
  config.subject = "#{Rails.env.upcase} StatusCat Failure"

end